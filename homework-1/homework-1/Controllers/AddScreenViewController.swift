//
//  ViewController.swift
//  homework-1
//
//  Created by Кабулов Нурсултан Пернебаевич on 14.04.2023.
//

import UIKit

class AddScreenViewController: UIViewController {

	var body: Body?
	let stackView = UIStackView()
	let manufacturerView = TextView(title: "Производитель",
									keyboardType: .asciiCapable)

	let modelView = TextView(title: "Модель",
							 keyboardType: .asciiCapable)

	let bodyPickerView = UIPickerView()
	let bodyView = TextView(title: "Тип кузова",
							keyboardType: .asciiCapable)

	let yearOfIssueView = TextView(title: "Год выпуска",
								   keyboardType: .numberPad)

	let carNumberView = TextView(title: "Гос. номер",
								 keyboardType: .asciiCapable)

	let addButton = UIButton(type: .system)

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		style()
		layout()
		hideKeyboardWhenTappedAround()
		setupKeyboardHiding()
	}
}

extension AddScreenViewController: UIPickerViewDelegate, UIPickerViewDataSource {

	func style() {
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.distribution = .equalCentering
		stackView.axis = .vertical

		manufacturerView.translatesAutoresizingMaskIntoConstraints = false
		manufacturerView.delegate = self

		modelView.translatesAutoresizingMaskIntoConstraints = false
		modelView.delegate = self

		bodyPickerView.translatesAutoresizingMaskIntoConstraints = false
		bodyPickerView.delegate = self
		
		bodyView.translatesAutoresizingMaskIntoConstraints = false
		bodyView.textField.inputView = bodyPickerView
		bodyView.delegate = self
		bodyView.textField.tintColor = .clear

		yearOfIssueView.translatesAutoresizingMaskIntoConstraints = false

		carNumberView.translatesAutoresizingMaskIntoConstraints = false

		addButton.translatesAutoresizingMaskIntoConstraints = false
		addButton.configuration = .filled()
		addButton.setTitle("Добавить машину", for: .normal)
		addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)

	}

	func layout() {
		stackView.addArrangedSubview(manufacturerView)
		stackView.addArrangedSubview(modelView)
		stackView.addArrangedSubview(bodyView)
		stackView.addArrangedSubview(yearOfIssueView)
		stackView.addArrangedSubview(carNumberView)
		view.addSubview(stackView)
		view.addSubview(addButton)

		NSLayoutConstraint.activate([
			stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
			stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
			view.trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 2)
		])

		NSLayoutConstraint.activate([
			addButton.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
			view.trailingAnchor.constraint(equalToSystemSpacingAfter: addButton.trailingAnchor, multiplier: 2),
			view.bottomAnchor.constraint(equalToSystemSpacingBelow: addButton.bottomAnchor, multiplier: 2)
		])
	}

	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return 1
	}

	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		return Body.count
	}

	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		bodyView.textField.text = Body(rawValue: row)?.description
		if let bodyValue = Body(rawValue: row) {
			body = bodyValue
		}
		return Body(rawValue: row)?.description
	}

	func hideKeyboardWhenTappedAround() {
		let tapGesture = UITapGestureRecognizer(target: self,
												action: #selector(hideKeyboard))
		view.addGestureRecognizer(tapGesture)
	}

	@objc func hideKeyboard() {
		view.endEditing(true)
	}

	func setupKeyboardHiding() {
		NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
	}

	@objc func addButtonTapped(_ sender: UIButton) {
		let isValid = validateTextFields()
		if isValid {
			guard let manufaturer = manufacturerView.textField.text,
				  let model = modelView.textField.text,
				  let body = body,
				  let year = yearOfIssueView.textField.text,
				  let carNumber = carNumberView.textField.text else { return }
			let yearOfIssue = Int(year)
			addNewCar(Car(manufaturer: manufaturer, model: model, body: body, yearOfIssue: yearOfIssue, carNumber: carNumber))
			reset()
		}
	}
}

// MARK: - TextViewDelegate

extension AddScreenViewController: TextViewDelegate {

	func focusLosed(_ sender: TextView) {
		if sender === manufacturerView {
			_ = manufacturerView.validate()
		} else if sender === modelView {
			_ = modelView.validate()
		} else if sender === bodyView {
			_ = bodyView.validate()
		}
	}

	@objc func keyboardWillShow(sender: NSNotification) {
		guard let userInfo = sender.userInfo,
			  let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
			  let currentTextField = UIResponder.currentFirst() as? UITextField else { return }


		let keyboardTopY = keyboardFrame.cgRectValue.origin.y

		let convertedTextFieldFrame = view.convert(currentTextField.frame, from: currentTextField.superview)

		let textFieldBottomY = convertedTextFieldFrame.origin.y + convertedTextFieldFrame.size.height

		if textFieldBottomY > keyboardTopY {
			let textBoxY = convertedTextFieldFrame.origin.y
			let newFrameY = ( textBoxY - keyboardTopY / 1.2 ) * -1
			view.frame.origin.y = newFrameY
		}
	}

	@objc func keyboardWillHide(sender: Notification) {
		view.frame.origin.y = 0
	}

	func validateTextFields() -> Bool {
		let isManufaturerValid = manufacturerView.validate()
		let isModelValid = modelView.validate()
		let isBodyValid = bodyView.validate()

		if isManufaturerValid && isModelValid && isBodyValid {
			return true
		}
		return false
	}

	func reset() {
		manufacturerView.textField.text = ""
		modelView.textField.text = ""
		bodyView.textField.text = ""
		yearOfIssueView.textField.text = ""
		carNumberView.textField.text = ""
	}
}
