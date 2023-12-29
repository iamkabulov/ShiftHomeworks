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
	private let container = NSPersistentContainer(name: "CurrencyDataModel")
	private var context: NSManagedObjectContext
	private var currency: [CurrencyData] = []

	init() {
		self.context = self.container.viewContext
		self.network = CurrencyListNetwork()
		self.container.loadPersistentStores { _, error in
			print(error)
			print("Container: Something went wrong")
		}
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
			try context.save()
		} catch {
			print("ERROR saving")
		}
	}

	func saveCurrency(code: String, name: String) {
		let newEntity = CurrencyData(context: self.context)
		newEntity.name = name
		newEntity.code = code
		self.currency.append(newEntity)
		saveContext()
	}

	func deleteCurrency(code: String, name: String) {
		let request = CurrencyData.fetchRequest()
		do {
			let entities = try context.fetch(request)
			entities.forEach { entity in
				print(code, name)
				if code == entity.code && name == entity.name {
					print("DELETING \(entity)")
					context.delete(entity)
				}
			}
		} catch {
			print("deleting error: -------")
		}
		saveContext()
	}

	func getCurrencies() {
		let request = CurrencyData.fetchRequest()
		do {
			var currencies: [Currency] = []
			let entities = try context.fetch(request)
			entities.forEach { entity in
				let code = entity.code
				let name = entity.name
				currencies.append(Currency(code: code, name: name))
			}
			self._presenter?.getCurrencies(currencies: currencies)
		} catch {
			print("loading error: ------")
		}
	}
}
