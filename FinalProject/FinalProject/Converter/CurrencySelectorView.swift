//
//  CurrencySelectorView.swift
//  FinalProject
//
//  Created by Кабулов Нурсултан Пернебаевич on 16.06.2023.
//

import UIKit
protocol ICurrencySelectorViewDelegate: AnyObject
{
	func didChanged()
	func didBeginEditing(_ view: CurrencySelectorView)
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
	private var isLoading = false
	private var currencyForActions = [Currency]()

	private var isLoadedRateResult: Bool = true

	lazy private var currencySelectorButton: CurrencySelectorCellView = {
		let ui = CurrencySelectorCellView()
		ui.showsMenuAsPrimaryAction = true
		return ui
	}()

	weak var delegate: ICurrencySelectorViewDelegate?
	
	lazy private var amount: InputView = {
		let input = InputView()
		return input
	}()

	lazy private var loadingAmount: LoadingInputView = {
		let input = LoadingInputView()
		return input
	}()

	override init(frame: CGRect) {
		super.init(frame: frame)
		setupView(amount)
		amount.delegate = self
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension CurrencySelectorView: IInputViewDelegate
{
//	func resultLoaded(_ result: Bool) {
//		if result {
//			setupView(amount)
//		} else {
//			setupView(loadingAmount)
//		}
//	}
	func resetInput() {
		amount.reset()
	}

	func makeActions(currencies: [Currency]) {
		let actions = currencies.map { currency in
			let code = currency.code
			let imageName = currency.findFlagImage(code)
			return UIAction(title: code, image: UIImage(named: imageName), handler: { (_) in
				if self.currencySelectorButton.getCurrency() != code {
					self.currencySelectorButton.didTappedHandler(code: imageName, name: code)
					self.amount.getAmount()
				}
			})
		}
		self.currencySelectorButton.menu = UIMenu(title: "", image: nil, identifier: nil, options: [], children: actions)
	}

	func setRate(_ result: PairExchangeRateWithAmount) {
		amount.setRateResult(result)
	}

	func setCurrency(_ currency: Currency?) {
		guard let currency = currency else { return }
		currencySelectorButton.setCurrency(currency)
//		menuItems.append(makeCurrencies(name: currency.code, code: currency.findFlagImage(currency.code)))
//		currencySelectorButton.menu = UIMenu(title: "", image: nil, identifier: nil, options: [], children: menuItems)
	}

	func getCurrency() -> String {
		return currencySelectorButton.getCurrency()
	}

	func getText() -> Double {
		let amount = amount.getText()
		return amount
	}

	func getAmount(_ textField: UITextField) {
		print("______selector")
		delegate?.didChanged()
		print("______selector")
	}

	func textFieldDidBeginEditing(_ textField: UITextField) {
		delegate?.didBeginEditing(self)
	}

	func textFieldDidReturn(_ textField: UITextField) {
		print("______selector")
		delegate?.didChanged()
		print("______selector")
	}

	func loading(_ result: Bool) {
		isLoading = result
		resetView()
	}

	func resetView() {
		if isLoading {
			removeView(amount)
			setupView(loadingAmount)
		} else {
			removeView(loadingAmount)
			setupView(amount)
		}
	}

	func setupView(_ view: UIView) {
		currencySelectorButton.translatesAutoresizingMaskIntoConstraints = false
		view.translatesAutoresizingMaskIntoConstraints = false

		addSubview(view)
		addSubview(currencySelectorButton)
		NSLayoutConstraint.activate([
			view.topAnchor.constraint(equalTo: topAnchor),
			view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.Spacing.medium),
			view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Metrics.Spacing.medium),
			currencySelectorButton.topAnchor.constraint(equalTo: view.bottomAnchor, constant: Metrics.Spacing.medium),
			currencySelectorButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			currencySelectorButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			currencySelectorButton.bottomAnchor.constraint(equalTo: bottomAnchor)
		])
	}

	func removeView(_ view: UIView) {
		NSLayoutConstraint.deactivate([
			view.topAnchor.constraint(equalTo: topAnchor),
			view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.Spacing.medium),
			view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Metrics.Spacing.medium),
			currencySelectorButton.topAnchor.constraint(equalTo: view.bottomAnchor, constant: Metrics.Spacing.medium),
			currencySelectorButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			currencySelectorButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			currencySelectorButton.bottomAnchor.constraint(equalTo: bottomAnchor)
		])
	}
}

//MARK: - UITextfield padding correction
