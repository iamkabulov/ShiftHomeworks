//
//  Currency+CoreData.swift
//  FinalProject
//
//  Created by Nursultan Kabulov on 29.12.2023.
//

import Foundation
import CoreData


public class CurrencyData: NSManagedObject {

}

extension CurrencyData {

	@nonobjc public class func fetchRequest() -> NSFetchRequest<CurrencyData> {
		return NSFetchRequest<CurrencyData>(entityName: "Currency")
	}

	@NSManaged public var code: String
	@NSManaged public var name: String

}

extension CurrencyData: Identifiable {

}

class CurrencyCoreData {

	let container: NSPersistentContainer
	let context: NSManagedObjectContext
	static let shared = CurrencyCoreData()

	private init() {
		self.container = NSPersistentContainer(name: "CurrencyDataModel")
		self.context = self.container.viewContext
		self.container.loadPersistentStores { _, error in
			guard let error = error else { return }
			print(error)
			print("Container: Something went wrong")
		}
	}

}
