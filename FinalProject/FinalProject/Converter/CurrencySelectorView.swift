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

	private var isLoadedRateResult: Bool = true

	lazy private var menuItems: [UIAction] = {
		[
			UIAction(title: "USD", image: UIImage(named: "us"), handler: { (_) in
				if self.currencySelectorButton.getCurrency() != "USD" {
					self.currencySelectorButton.didTappedHandler(code:"us", name: "USD")
					self.amount.getAmount()
				}
			}),
			UIAction(title: "EUR", image: UIImage(named: "ea"), handler: { (_) in
				if self.currencySelectorButton.getCurrency() != "EUR" {
					self.currencySelectorButton.didTappedHandler(code:"ea", name: "EUR")
					self.amount.getAmount()
				}
			}),
			UIAction(title: "KZT", image: UIImage(named: "kz"), handler: { (_) in
				if self.currencySelectorButton.getCurrency() != "KZT" {
					self.currencySelectorButton.didTappedHandler(code:"kz", name: "KZT")
					self.amount.getAmount()
				}
			})
		]
	}()

	lazy private var demoMenu: UIMenu = {
	  return UIMenu(title: "", image: nil, identifier: nil, options: [], children: menuItems)
	}()

	lazy private var currencySelectorButton: CurrencySelectorCellView = {
		let ui = CurrencySelectorCellView()
		ui.menu = demoMenu
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

	func makeCurrencies(name: String, code: String) -> UIAction {
		return UIAction(title: name, image: UIImage(named: code), handler: { (_) in
			if self.currencySelectorButton.getCurrency() != name {
				self.currencySelectorButton.didTappedHandler(code: code, name: name)
				self.amount.getAmount()
			}
		})
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

	func textFieldDidReturn(_ textField: UITextField) {
		print("______selector")
		delegate?.didChanged()
		print("______selector")
	}

	func setupView(_ view: UIView) {
		currencySelectorButton.translatesAutoresizingMaskIntoConstraints = false
		amount.translatesAutoresizingMaskIntoConstraints = false
		loadingAmount.translatesAutoresizingMaskIntoConstraints = false

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
}

//MARK: - UITextfield padding correction
