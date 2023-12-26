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
	func setRateResult(_ result: PairExchangeRateWithAmount) {
		let rate = result.conversionResult
		input.text = String(format: "%.1f", rate)
	}

	func getAmount() {
		delegate?.getAmount(input)
	}

	func getText() -> Double {
		guard let text = input.text else { return 0 }
		guard let amount = Double(text) else { return 0 }
		return amount
	}

	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		print("Input")
		delegate?.textFieldDidReturn(textField)
		input.resignFirstResponder()
		return true
	}

	func setupView() {
		input.translatesAutoresizingMaskIntoConstraints = false
		addSubview(input)
		NSLayoutConstraint.activate([
			input.topAnchor.constraint(equalTo: topAnchor, constant: 5),
			input.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
			input.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
			input.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)
		])
	}
}


