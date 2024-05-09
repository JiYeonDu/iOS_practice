//
//  LastSearchBook+CoreDataProperties.swift
//  Booker
//
//  Created by 신지연 on 2024/05/08.
//
//

import Foundation
import CoreData


extension LastSearchBook {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LastSearchBook> {
        return NSFetchRequest<LastSearchBook>(entityName: "LastSearchBook")
    }

    @NSManaged public var imageURL: String?
    @NSManaged public var title: String?

}

extension LastSearchBook : Identifiable {

}
