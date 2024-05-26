//
//  InputView.swift
//  FinalProject
//
//  Created by Nursultan Kabulov on 15.12.2023.
//

import UIKit
protocol IInputViewDelegate: AnyObject
{
	func textFieldDidReturn(_ textField: UITextField)
	func textFieldDidBeginEditing(_ textField: UITextField)
	func getAmount(_ textField: UITextField)
}

final class InputView: UIView {

	lazy private var input: UITextField = {
		let amount = UITextField()
		amount.textAlignment = .right
		amount.font = UIFont.preferredFont(forTextStyle: .largeTitle)
		amount.placeholder = "0"
		amount.backgroundColor = .systemBackground
		return amount
	}()
	
	weak var delegate: IInputViewDelegate?

	override init(frame: CGRect) {
		super.init(frame: frame)
		setupView()
		self.input.delegate = self
		self.layer.cornerRadius = 5
		self.layer.borderWidth = 0.7
		self.layer.borderColor = UIColor.black.cgColor
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

//MARK: - Extension
extension InputView: UITextFieldDelegate
{
	//TODO: - NUZHNO DOBAVIT' SHOULD START BEGAN DLYA SBROSA NA 0
	func reset() {
		self.input.text = "0"
	}

	func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
		print("Begin Editing")
		delegate?.textFieldDidBeginEditing(self.input)
		return true
	}
	
	func setRateResult(_ result: PairExchangeRateWithAmount) {
		let rate = result.conversionResult
		self.input.text = String(format: "%.1f", rate)
	}

	func getAmount() {
		delegate?.getAmount(self.input)
	}

	func getText() -> Double {
		guard let text = self.input.text else { return 0 }
		guard let amount = Double(text) else { return 0 }
		return amount
	}

	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		print("Input")
		delegate?.textFieldDidReturn(textField)
		self.input.resignFirstResponder()
		return true
	}

	func setupView() {
		self.input.translatesAutoresizingMaskIntoConstraints = false
		addSubview(self.input)
		NSLayoutConstraint.activate([
			self.input.topAnchor.constraint(equalTo: topAnchor, constant: 5),
			self.input.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
			self.input.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
			self.input.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)
		])
	}
}


