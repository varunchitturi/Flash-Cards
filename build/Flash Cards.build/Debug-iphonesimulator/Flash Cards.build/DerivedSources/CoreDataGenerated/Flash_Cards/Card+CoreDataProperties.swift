//
//  Card+CoreDataProperties.swift
//  
//
//  Created by Varun Chitturi on 5/10/20.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension Card {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Card> {
        return NSFetchRequest<Card>(entityName: "Card")
    }

    @NSManaged public var back: String?
    @NSManaged public var front: String?
    @NSManaged public var deck: Deck?

}
