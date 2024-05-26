//
//  ConverterInteractor.swift
//  FinalProject
//
//  Created by Кабулов Нурсултан Пернебаевич on 16.06.2023.
//

import Foundation
import CoreData

protocol IConverterInteractor: AnyObject
{
	func loadExchangeRate(_ code: String)
	func loadPairExchangeRate(from: String, to: String)
	func loadPairExchangeRateWithAmount(from: String, to: String, amount: Double)
}

final class ConverterInteractor
{
	weak var _presenter: ConverterPresenter?
	private let network = ConverterNetwork()
	private let coreData = CurrencyCoreData.shared
	private var currency: [CurrencyData] = []
}

extension ConverterInteractor: IConverterInteractor, InteractorProtocol
{
	var presenter: PresenterProtocol? {
		get {
			return self._presenter
		}
		set {
			self._presenter = newValue as? ConverterPresenter
		}
	}

	func loadExchangeRate(_ code: String) {
		self.network.loadRates(code: code) { result in
			switch result {
			case .success(let currencies):
				print(currencies)
			case .failure(let error):
				print(error.localizedDescription)
			}
		}
	}

	func loadPairExchangeRate(from: String, to: String) {
		self.network.loadPairRates(from: from, to: to) { result in
			switch result {
			case .success(let currencies):
				print(currencies)
			case .failure(let error):
				print(error.localizedDescription)
			}
		}
	}

	func loadPairExchangeRateWithAmount(from: String, to: String, amount: Double) {
		self.network.loadPairRatesWithAmount(from: from, to: to, amount: amount) { result in
			switch result {
			case .success(let res):
				self._presenter?.showExchangeRate(result: res)
			case .failure(let error):
				print(error.localizedDescription)
			}
		}
	}

	func getSavedCurrencies() {
		let request = CurrencyData.fetchRequest()
		do {
			var currencies: [Currency] = []
			let entities = try self.coreData.context.fetch(request)
			entities.forEach { entity in
				let code = entity.code
				let name = entity.name
				currencies.append(Currency(code: code, name: name))
			}
			self._presenter?.getCurrencies(currencies: currencies)
			print(currencies)
		} catch {
			print("loading error: ------")
		}
	}
}
