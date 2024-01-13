//
//  CurrencyListInteractor.swift
//  FinalProject
//
//  Created by Кабулов Нурсултан Пернебаевич on 15.06.2023.
//

import Foundation
import CoreData

protocol ICurrencyListInteractor: AnyObject
{
	func loadCurrencies()
	func saveCurrency(code: String, name: String)
}

final class CurrencyListInteractor
{
	weak var _presenter: CurrencyListPresenter?
	private let network: CurrencyListNetwork
	private let coreData = CurrencyCoreData.shared
	private var currency: [CurrencyData] = []

	init() {
		self.network = CurrencyListNetwork()
	}
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
	func saveContext() {
		do {
			try self.coreData.context.save()
			self.getSavedCurrencies()
		} catch {
			print("ERROR saving")
		}
	}

	func saveCurrency(code: String, name: String) {
		let newEntity = CurrencyData(context: self.coreData.context)
		newEntity.name = name
		newEntity.code = code
		self.currency.append(newEntity)
		saveContext()
	}

	func deleteCurrency(code: String, name: String) {
		let request = CurrencyData.fetchRequest()
		do {
			let entities = try self.coreData.context.fetch(request)
			entities.forEach { entity in
				print(code, name)
				if code == entity.code && name == entity.name {
					print("DELETING \(entity)")
					self.coreData.context.delete(entity)
				}
			}
		} catch {
			print("deleting error: -------")
		}
		saveContext()
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
