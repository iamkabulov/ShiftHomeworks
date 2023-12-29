//
//  CoverterView.swift
//  FinalProject
//
//  Created by Кабулов Нурсултан Пернебаевич on 16.06.2023.
//

import UIKit

protocol ICoverterView: AnyObject
{
	var twoCurrencies: ((String, String, Double) -> Void)? { get set }
	func showRate(_ result: PairExchangeRateWithAmount)
}

final class CoverterView: UIView
{
	lazy private var from: CurrencySelectorView = {
		let ui = CurrencySelectorView()
		return ui
	}()

	lazy private var to: CurrencySelectorView = {
		let ui = CurrencySelectorView()
		return ui
	}()

	weak var selectorViewDelegate: ICurrencySelectorViewDelegate?
	weak var delegate: ICoverterView?
	var amountReturnHandler: ((Double) -> Void)?
	var currencyReturnHandler: ((String) -> Void)?
	var twoCurrencies: ((String, String, Double) -> Void)?
	
	lazy private var stack: UIStackView = {
		let stack = UIStackView()
		stack.distribution = .fillProportionally
		stack.alignment = .center
		stack.axis = .horizontal
		return stack
	}()

	override init(frame: CGRect) {
		super.init(frame: frame)
		setupView()
		configure()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension CoverterView: ICoverterView, ICurrencySelectorViewDelegate
{
	func showRate(_ result: PairExchangeRateWithAmount) {
		to.setRate(result)
	}

	func loadCode(_ code: Currency?) {
		print("\(code) Converter VIEW ______")
		to.setCurrency(Currency(code: "KZT", name: "Kazakhstani tenge"))
		from.setCurrency(Currency(code: "USD", name: "US Dollars"))
	}
	
	func didChanged() {
		let fromCurrency = from.getCurrency()
		let toCurrency = to.getCurrency()
		let amount = from.getText()
		twoCurrencies?(fromCurrency, toCurrency, amount)
	}

	func configure() {
		stack.translatesAutoresizingMaskIntoConstraints = false
		from.translatesAutoresizingMaskIntoConstraints = false
		to.translatesAutoresizingMaskIntoConstraints = false
		from.delegate = self
		to.delegate = self

	}

	func setupView() {
		stack.addArrangedSubview(from)
		stack.addArrangedSubview(to)
//		stack.addArrangedSubview()
		addSubview(stack)
		NSLayoutConstraint.activate([
			stack.topAnchor.constraint(equalTo: topAnchor, constant: 20),
			stack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
			stack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
			stack.heightAnchor.constraint(equalToConstant: 200),
		])
	}

	
}
