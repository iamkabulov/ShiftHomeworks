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
