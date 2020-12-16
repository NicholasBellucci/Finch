//
//  Conversion+CoreDataClass.swift
//  Finch
//
//  Created by Nicholas Bellucci on 12/15/20.
//
//

import Foundation
import CoreData

@objc(Conversion)
public class Conversion: NSManagedObject {

}

extension Conversion {
    @nonobjc public class func createFetchRequest() -> NSFetchRequest<Conversion> {
        return NSFetchRequest<Conversion>(entityName: "Conversion")
    }

    @NSManaged public var id: UUID
    @NSManaged public var name: String
    @NSManaged public var json: String
    @NSManaged public var language: Int16

}

extension Conversion : Identifiable {

}
