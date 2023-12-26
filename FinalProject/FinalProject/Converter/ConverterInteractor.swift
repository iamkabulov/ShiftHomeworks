//
//  ConverterInteractor.swift
//  FinalProject
//
//  Created by Кабулов Нурсултан Пернебаевич on 16.06.2023.
//

import Foundation

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
				print(res)
				self._presenter?.showExchangeRate(result: res)
			case .failure(let error):
				print(error.localizedDescription)
			}
		}
	}
}
