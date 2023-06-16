//
//  CurrencySelectorView.swift
//  FinalProject
//
//  Created by Кабулов Нурсултан Пернебаевич on 16.06.2023.
//

import UIKit

protocol ICurrencySelectorView: AnyObject
{
	func textFieldDidReturn(_ textField: UITextField)
}

final class CurrencySelectorView: UIView
{
	private enum Metrics {
		static let height: CGFloat = 32
		static let width: CGFloat = 56
		enum Spacing {
			static let small: CGFloat = 2
			static let medium: CGFloat = 8
		}
	}

	lazy private var ui: CurrencySelectorCellView = {
		let ui = CurrencySelectorCellView()
		return ui
	}()

	weak var delegate: ICurrencySelectorView?
	lazy private var amount: UITextField = {
		let amount = UITextField()
		amount.placeholder = "0"
		amount.backgroundColor = .systemBackground
		return amount
	}()

	init() {
		super.init(frame: .zero)
		setupView()
		backgroundColor = .orange
		amount.delegate = self

	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension CurrencySelectorView: UITextFieldDelegate
{
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		delegate?.textFieldDidReturn(textField)
		print("VIEW")
		return true
	}

	func setupView() {
		ui.translatesAutoresizingMaskIntoConstraints = false
		amount.translatesAutoresizingMaskIntoConstraints = false

		addSubview(amount)
		addSubview(ui)
		NSLayoutConstraint.activate([
			amount.topAnchor.constraint(equalTo: topAnchor, constant: 20),
			amount.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
			ui.topAnchor.constraint(equalTo: amount.bottomAnchor, constant: Metrics.Spacing.medium),
			ui.leadingAnchor.constraint(equalTo: amount.leadingAnchor),
		])
	}
}
