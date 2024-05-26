//
//  CoverterView.swift
//  FinalProject
//
//  Created by Кабулов Нурсултан Пернебаевич on 16.06.2023.
//

import UIKit

protocol ICoverterView: AnyObject
{
	var getExchangeRateHandler: ((String, String, Double) -> Void)? { get set }
	func showRate(_ result: PairExchangeRateWithAmount)
	func loading(from: String, to: String, result: Bool)
	func setCurrenciesToAction(_ currencies: [Currency])
}

final class CoverterView: UIView
{
	private var previousFromCurrencyInputAmountValue: Double = 0
	private var previousToCurrencyInputAmountValue: Double = 0
	private var previousFromCurrencyCode: String = ""
	private var previousToCurrencyCode: String = ""

	lazy private var fromCurrencyInputView: CurrencySelectorView = {
		let ui = CurrencySelectorView()
		return ui
	}()

	lazy private var toCurrencyInputView: CurrencySelectorView = {
		let ui = CurrencySelectorView()
		return ui
	}()

	weak var delegate: ICoverterView?
	var getExchangeRateHandler: ((String, String, Double) -> Void)?
	
	lazy private var converterStackView: UIStackView = {
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
	func loading(from: String, to: String, result: Bool) {
		if from == self.fromCurrencyInputView.getCurrency() && to == self.toCurrencyInputView.getCurrency() {
			self.toCurrencyInputView.loading(result)
		} else if from == self.toCurrencyInputView.getCurrency() && to == self.fromCurrencyInputView.getCurrency() {
			self.fromCurrencyInputView.loading(result)
		}
	}

	func showRate(_ result: PairExchangeRateWithAmount) {
		if result.baseCode == toCurrencyInputView.getCurrency() {
			sleep(1)
			// Кажется нужно сделать для все один метод
			fromCurrencyInputView.loading(false)
			fromCurrencyInputView.setRate(result)
			self.previousFromCurrencyInputAmountValue = fromCurrencyInputView.getText()
		} else if result.baseCode == fromCurrencyInputView.getCurrency() {
			sleep(1)
			// Кажется нужно сделать для все один метод
			toCurrencyInputView.loading(false)
			toCurrencyInputView.setRate(result)
			self.previousToCurrencyInputAmountValue = toCurrencyInputView.getText()
		}
	}

	func setCurrenciesToAction(_ currencies: [Currency]) {
		toCurrencyInputView.makeActions(currencies: currencies)
		fromCurrencyInputView.makeActions(currencies: currencies)
	}

	func loadCode(_ currency: Currency?) {
		fromCurrencyInputView.setCurrency(Currency(code: "USD", name: "US Dollars"))
		guard let code = currency?.code, let name = currency?.name else { return }
		toCurrencyInputView.setCurrency(Currency(code: code, name: name))
	}
	
	func didChanged() {
		let currentFromCurrencyCode = fromCurrencyInputView.getCurrency()
		let currentToCurrencyCode = toCurrencyInputView.getCurrency()
		let currentFromAmountValue = fromCurrencyInputView.getText()
		let currentToAmountValue = toCurrencyInputView.getText()
		if (currentFromAmountValue > 0.0 && currentFromAmountValue != self.previousFromCurrencyInputAmountValue) || ( currentFromAmountValue > 0.0 && currentFromCurrencyCode != self.previousFromCurrencyCode)
		{
			self.previousFromCurrencyInputAmountValue = currentFromAmountValue
			self.previousFromCurrencyCode = currentFromCurrencyCode
			getExchangeRateHandler?(currentFromCurrencyCode, currentToCurrencyCode, currentFromAmountValue)
		}
		else if (currentToAmountValue > 0.0 && currentToAmountValue != self.previousToCurrencyInputAmountValue) || (currentToAmountValue > 0.0 && currentToCurrencyCode != self.previousToCurrencyCode)
		{
			self.previousToCurrencyInputAmountValue = currentToAmountValue
			self.previousToCurrencyCode = currentToCurrencyCode
			getExchangeRateHandler?(currentToCurrencyCode, currentFromCurrencyCode, currentToAmountValue)
		}
	}

	func didBeginEditing(_ view: CurrencySelectorView) {
		if view == fromCurrencyInputView {
			toCurrencyInputView.loading(false)
			toCurrencyInputView.resetInput()
		} else if view == toCurrencyInputView {
			fromCurrencyInputView.loading(false)
			fromCurrencyInputView.resetInput()
		}
	}

	func configure() {
		converterStackView.translatesAutoresizingMaskIntoConstraints = false
		fromCurrencyInputView.translatesAutoresizingMaskIntoConstraints = false
		toCurrencyInputView.translatesAutoresizingMaskIntoConstraints = false
		fromCurrencyInputView.delegate = self
		toCurrencyInputView.delegate = self

	}

	func setupView() {
		converterStackView.addArrangedSubview(fromCurrencyInputView)
		converterStackView.addArrangedSubview(toCurrencyInputView)
		addSubview(converterStackView)
		NSLayoutConstraint.activate([
			converterStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 2),
			converterStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
			converterStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
		])
	}
}
