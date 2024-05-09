//
//  Cart+CoreDataProperties.swift
//  Booker
//
//  Created by 신지연 on 2024/05/08.
//
//

import Foundation
import CoreData


extension Cart {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Cart> {
        return NSFetchRequest<Cart>(entityName: "Cart")
    }

    @NSManaged public var title: String?
    @NSManaged public var price: Int32
    @NSManaged public var author: String?

}

extension Cart : Identifiable {

}
