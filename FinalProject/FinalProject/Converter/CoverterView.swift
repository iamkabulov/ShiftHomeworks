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
	func setCurrenciesToAction(_ currencies: [Currency])
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
		if result.baseCode == to.getCurrency() {
			sleep(2)
			from.loading(false)
			from.setRate(result)
		} else if result.baseCode == from.getCurrency() {
			sleep(2)
			to.loading(false)
			to.setRate(result)
		}
	}

	func setCurrenciesToAction(_ currencies: [Currency]) {
		to.makeActions(currencies: currencies)
		from.makeActions(currencies: currencies)
	}

	func loadCode(_ currency: Currency?) {
		from.setCurrency(Currency(code: "USD", name: "US Dollars"))
		guard let code = currency?.code, let name = currency?.name else { return }
		to.setCurrency(Currency(code: code, name: name))
	}
	
	func didChanged() {
		let fromCurrency = from.getCurrency()
		let toCurrency = to.getCurrency()
		let amountFrom = from.getText()
		let amountTo = to.getText()
		// TUT mozhet byt' oshibka
		if amountFrom > 0 {
			print("FROM_____")
			twoCurrencies?(fromCurrency, toCurrency, amountFrom)
			to.loading(true)
		} else if amountTo > 0 {
			print("TO_____")
			twoCurrencies?(toCurrency, fromCurrency, amountTo)
			from.loading(true)
		}
	}

	func didBeginEditing(_ view: CurrencySelectorView) {
		if view == from {
			to.resetInput()
		} else if view == to {
			from.resetInput()
		}
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
			stack.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 2),
			stack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
			stack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
		])
	}

	
}
