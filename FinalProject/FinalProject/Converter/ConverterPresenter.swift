//
//  ConverterPresenter.swift
//  FinalProject
//
//  Created by Кабулов Нурсултан Пернебаевич on 16.06.2023.
//

import Foundation

protocol IConverterPresenter: AnyObject
{
	func viewDidLoad(view: ICoverterView, viewController: ConverterViewController)
	func showExchangeRate(result: PairExchangeRateWithAmount)
	func getCurrencies(currencies: [Currency])
}

final class ConverterPresenter {
	weak var _converterView: ICoverterView?
	weak var _viewController: ConverterViewController?
	private var _interactor: ConverterInteractor?
	private var _router: ConverterRouter?
}

extension ConverterPresenter: IConverterPresenter, PresenterProtocol
{
	var router: RouterProtocol? {
		get {
			return self._router
		}
		set {
			self._router = newValue as? ConverterRouter
		}
	}

	var interactor: InteractorProtocol? {
		get {
			return self._interactor
		}
		set {
			self._interactor = newValue as? ConverterInteractor
		}
	}

	var viewController: ViewProtocol? {
		get {
			return self._viewController
		}
		set {
			self._viewController = newValue as? ConverterViewController
		}
	}

	func getCurrencies(currencies: [Currency]) {
		self._converterView?.setCurrenciesToAction(currencies)	}

	func showExchangeRate(result: PairExchangeRateWithAmount) {
		self._converterView?.showRate(result)
	}

	func getSavedCurrencies() {
		self._interactor?.getSavedCurrencies()
	}

	func viewDidLoad(view: ICoverterView, viewController: ConverterViewController) {
		self._converterView = view

		self._interactor?.getSavedCurrencies()
//		self._converterView?.amountReturnHandler = { amount in
//			print("\(amount) Presenter")
//		}
//		self._converterView?.currencyReturnHandler = { currency in
//			print("\(currency) Presenter")
//			self._interactor?.loadExchangeRate(currency)
//		}
		self._converterView?.twoCurrencies = { from, to, amount in
			print("\(from) Presenter")
			print("\(to) Presenter")
			guard from != to else {
				self._router?.showAlert(viewController: viewController, title: "Please choose another currency", message: "salamaleikum")
				self._converterView?.loading(from: from, to: to, result: false)
				return
			}
			self._interactor?.loadPairExchangeRateWithAmount(from: from, to: to, amount: amount)
			self._converterView?.loading(from: from, to: to, result: true)
		}
	}
}

