//
//  ListScreenViewController.swift
//  homework-1
//
//  Created by Кабулов Нурсултан Пернебаевич on 16.04.2023.
//

import UIKit

class ListScreenViewController: UIViewController {

	let tableView = UITableView()
	let pickerView = UIPickerView()
	let stackView = UIStackView()
	var searchTextField = UITextField()
	var body: Body?
	var filtered = [Car]()
//	var cars = [Car]()
//	var cars = [Car(manufaturer: "TOYOTA", model: "CAMRY", body: Body.sedan, yearOfIssue: 1992, carNumber: nil),
//				Car(manufaturer: "KIA", model: "K5", body: Body.sedan, yearOfIssue: nil, carNumber: "777KZ")]


	override func viewDidLoad() {
		super.viewDidLoad()
		style()
		layout()
		hideKeyboardWhenTappedAround()
	}

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		refresh()
	}
}

extension ListScreenViewController {

	func style() {
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.axis = .vertical
		stackView.distribution = .fill

		pickerView.translatesAutoresizingMaskIntoConstraints = false
		pickerView.delegate = self
		searchTextField.translatesAutoresizingMaskIntoConstraints = false
		searchTextField.inputView = pickerView
		searchTextField.delegate = self
		searchTextField.backgroundColor = .systemBackground
		searchTextField.placeholder = "Поиск"
		searchTextField.layer.cornerRadius = 5
		
		tableView.backgroundColor = .systemGray5
		tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.reuseId)
		tableView.rowHeight = TableViewCell.rowHeight
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.delegate = self
		tableView.dataSource = self

	}

	func layout() {
		view.addSubview(searchTextField)
		view.addSubview(tableView)
		
		NSLayoutConstraint.activate([
			searchTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			searchTextField.leadingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.leadingAnchor, multiplier: 2),
			view.safeAreaLayoutGuide.trailingAnchor.constraint(equalToSystemSpacingAfter: searchTextField.trailingAnchor, multiplier: 2),
			tableView.topAnchor.constraint(lessThanOrEqualToSystemSpacingBelow: searchTextField.bottomAnchor, multiplier: 2),
			tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
			])
	}

	func hideKeyboardWhenTappedAround() {
		let tapGesture = UITapGestureRecognizer(target: self,
												action: #selector(hideKeyboard))
		view.addGestureRecognizer(tapGesture)
	}

	@objc func hideKeyboard() {
		view.endEditing(true)
	}
}

extension ListScreenViewController: UITableViewDataSource, UITableViewDelegate {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if textFieldShouldReturn(searchTextField) {
			return filtered.count
		} else {
			return cars.count
		}
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if textFieldShouldReturn(searchTextField) {
			guard !filtered.isEmpty else { return UITableViewCell() }
			let car = filtered[indexPath.row]
			let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.reuseId, for: indexPath) as! TableViewCell
			cell.configure(with: car)
			return cell
		} else {
			guard !cars.isEmpty else { return UITableViewCell() }
			let car = cars[indexPath.row]
			let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.reuseId, for: indexPath) as! TableViewCell
			cell.configure(with: car)
			return cell
		}
	}

	func refresh() {
		self.tableView.reloadData()
	}
}

extension ListScreenViewController: UIPickerViewDelegate, UIPickerViewDataSource {
	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return 1
	}

	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		return Body.count
	}

	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		searchTextField.text = Body(rawValue: row)?.description
		if let bodyValue = Body(rawValue: row) {
			body = bodyValue
		}
		return Body(rawValue: row)?.description
	}
}

extension ListScreenViewController: UITextFieldDelegate {
	func textFieldDidEndEditing(_ textField: UITextField) {
		guard let text = textField.text else { return }
		if text != "" {
			filtered = cars.filter { $0.body == body }
			refresh()
		}
	}
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		guard let text = textField.text else { return false }
		if text != "" {
			return true
		}
		return false
	}
}
