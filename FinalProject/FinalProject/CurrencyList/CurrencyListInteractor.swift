//
//  CurrencyListInteractor.swift
//  FinalProject
//
//  Created by Кабулов Нурсултан Пернебаевич on 15.06.2023.
//

import Foundation

protocol ICurrencyListInteractor: AnyObject
{
	func loadCurrencies()
}

final class CurrencyListInteractor
{
	weak var _presenter: CurrencyListPresenter?
	private let network = CurrencyListNetwork()
}

extension CurrencyListInteractor: ICurrencyListInteractor, InteractorProtocol
{
	var presenter: PresenterProtocol? {
		get {
			return self._presenter
		}
		set {
			self._presenter = newValue as? CurrencyListPresenter
		}
	}

	func loadCurrencies() {
		self.network.loadCurrencies { result in
			switch result {
			case .success(let currencies):
				self._presenter?.showCurrencies(currencies: currencies)
			case .failure(let error):
				print(error.localizedDescription)
			}
		}
	}
}
