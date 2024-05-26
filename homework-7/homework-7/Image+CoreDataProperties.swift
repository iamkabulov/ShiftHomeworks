//
//  Image+CoreDataProperties.swift
//  homework-7
//
//  Created by Кабулов Нурсултан Пернебаевич on 08.06.2023.
//
//

import Foundation
import CoreData


extension Image {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Image> {
        return NSFetchRequest<Image>(entityName: "Image")
    }

    @NSManaged public var data: Data?
    @NSManaged public var url: String?

}

extension Image : Identifiable {

}
