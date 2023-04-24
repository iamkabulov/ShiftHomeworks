//
//  TextView.swift
//  homework-1
//
//  Created by Кабулов Нурсултан Пернебаевич on 14.04.2023.
//

//
//  TextFieldView.swift
//  homework-1
//
//  Created by Кабулов Нурсултан Пернебаевич on 14.04.2023.
//

import UIKit

protocol TextViewDelegate: AnyObject {

	func focusLosed(_ sender: TextView)
}

class TextView: UIView {

	var cars = [Car]()
	let label = UILabel()
	let textField = UITextField()
	let stackView = UIStackView()
	let errorLabel = UILabel()
	weak var delegate: TextViewDelegate?

	init(title: String, keyboardType: UIKeyboardType) {
		self.label.text = title
		self.textField.keyboardType = keyboardType
		super.init(frame: .zero)
		style()
		layout()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override var intrinsicContentSize: CGSize {
		return CGSize(width: 200, height: 75)
	}
}

extension TextView {

	func style() {
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.axis = .vertical
		stackView.spacing = 4

		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont.preferredFont(forTextStyle: .body)

		textField.translatesAutoresizingMaskIntoConstraints = false
		textField.layer.cornerRadius = 5
		textField.backgroundColor = .systemBackground
		textField.delegate = self

		errorLabel.translatesAutoresizingMaskIntoConstraints = false
		errorLabel.textColor = .systemRed
		errorLabel.text = "Заполните обязательное поле"
		errorLabel.font = .preferredFont(forTextStyle: .footnote)
		errorLabel.isHidden = true
	}

	func layout() {
		stackView.addArrangedSubview(label)
		stackView.addArrangedSubview(textField)
		stackView.addArrangedSubview(errorLabel)

		addSubview(stackView)

		NSLayoutConstraint.activate([
			stackView.topAnchor.constraint(equalTo: topAnchor),
			stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
			stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
		])
		textField.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .horizontal)
	}
}


extension TextView {

	func validate() -> Bool {
		if textField.text == "" {
			errorLabel.isHidden = false
			return false
		} else {
			errorLabel.isHidden = true
			return true
		}
	}

	
}

extension TextView: UITextFieldDelegate {

	func textFieldDidEndEditing(_ textField: UITextField) {
		delegate?.focusLosed(self)
	}

	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		self.endEditing(true)
		return true
	}
}


