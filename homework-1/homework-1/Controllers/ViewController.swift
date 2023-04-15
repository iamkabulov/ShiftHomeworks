//
//  ViewController.swift
//  homework-1
//
//  Created by Кабулов Нурсултан Пернебаевич on 14.04.2023.
//

import UIKit

class ViewController: UIViewController {

	var body: Body?
	let stackView = UIStackView()
	let manufacturerTextField = TextView(title: "Производитель",
								keyboardType: .asciiCapable)

	let modelTextField = TextView(title: "Модель",
						 keyboardType: .asciiCapable)

	let bodyPickerView = UIPickerView()
	let bodyTextField = TextView(title: "Тип кузова",
								 keyboardType: .asciiCapable)

	let yearOfIssueTextField = TextView(title: "Год выпуска",
										keyboardType: .numberPad)

	let carNumberTextField = TextView(title: "Гос. номер",
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

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {

	func style() {
		stackView.translatesAutoresizingMaskIntoConstraints = false
//		stackView.spacing = 16
		stackView.distribution = .equalCentering
		stackView.axis = .vertical

		manufacturerTextField.translatesAutoresizingMaskIntoConstraints = false
		manufacturerTextField.delegate = self

		modelTextField.translatesAutoresizingMaskIntoConstraints = false
		modelTextField.delegate = self

		bodyPickerView.translatesAutoresizingMaskIntoConstraints = false
		bodyPickerView.delegate = self
		bodyTextField.translatesAutoresizingMaskIntoConstraints = false
		bodyTextField.textField.inputView = bodyPickerView
		bodyTextField.delegate = self
		
		bodyTextField.textField.tintColor = .clear
//		bodyTextField.textField.isUserInteractionEnabled = false

		yearOfIssueTextField.translatesAutoresizingMaskIntoConstraints = false

		carNumberTextField.translatesAutoresizingMaskIntoConstraints = false

		addButton.translatesAutoresizingMaskIntoConstraints = false
		addButton.configuration = .filled()
		addButton.setTitle("Добавить машину", for: .normal)
		addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)

	}

	func layout() {
		stackView.addArrangedSubview(manufacturerTextField)
		stackView.addArrangedSubview(modelTextField)
		stackView.addArrangedSubview(bodyTextField)
		stackView.addArrangedSubview(yearOfIssueTextField)
		stackView.addArrangedSubview(carNumberTextField)
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
		bodyTextField.textField.text = Body(rawValue: row)?.description
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
		let isManufaturerValid = manufacturerTextField.validate()
		let isModelValid = modelTextField.validate()
		let isBodyValid = bodyTextField.validate()

		if isManufaturerValid && isModelValid && isBodyValid {
			guard let manufaturer = manufacturerTextField.textField.text,
				  let model = modelTextField.textField.text,
				  let body = body,
				  let year = yearOfIssueTextField.textField.text,
				  let carNumber = carNumberTextField.textField.text else { return }
			let yearOfIssue = Int(year)
			appendik(Car(manufaturer: manufaturer, model: model, body: body, yearOfIssue: yearOfIssue, carNumber: carNumber))
			print(cars)
		} else {
			print("NOT OK")
		}
	}
}

// MARK: - TextViewDelegate

extension ViewController: TextViewDelegate {

	func focusLosed(_ sender: TextView) {
		if sender === manufacturerTextField {
			_ = manufacturerTextField.validate()
		} else if sender === modelTextField {
			_ = modelTextField.validate()
		} else if sender === bodyTextField {
			_ = bodyTextField.validate()
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
}
