//
//  CurrencyListPresenter.swift
//  FinalProject
//
//  Created by Кабулов Нурсултан Пернебаевич on 15.06.2023.
//

import Foundation

protocol ICurrencyListPresenter: AnyObject
{
	func viewDidLoad(tableView: ICurrencyListView, viewController: CurrencyListViewController)
	func showCurrencies(currencies: [Currency])
}

final class CurrencyListPresenter
{
	weak var tableView: ICurrencyListView?
	weak var _viewController: CurrencyListViewController?
	private var _interactor: CurrencyListInteractor?
	private var _router: CurrencyListRouter?

}

extension CurrencyListPresenter: ICurrencyListPresenter, PresenterProtocol
{
	var router: RouterProtocol? {
		get {
			return self._router
		}
		set {
			self._router = newValue as? CurrencyListRouter
		}
	}

	var interactor: InteractorProtocol? {
		get {
			return self._interactor
		}
		set {
			self._interactor = newValue as? CurrencyListInteractor
		}
	}

	var viewController: ViewProtocol? {
		get {
			return self._viewController
		}
		set {
			self._viewController = newValue as? CurrencyListViewController
		}
	}

	func viewDidLoad(tableView: ICurrencyListView, viewController: CurrencyListViewController) {
		self.tableView = tableView
		viewController.title = "Currencies"
//		self.viewController = viewController
		self.viewController = viewController
		self._interactor?.loadCurrencies()

		self.tableView?.currencyTappedHandler = { code in
			guard let viewController = self._viewController else { return }
			self._router?.currencyConverter(viewController: viewController, code)
		}
	}

	func showCurrencies(currencies: [Currency]) {
		self.tableView?.showCurrencies(currencies)
		self.tableView?.reload()
	}
}
