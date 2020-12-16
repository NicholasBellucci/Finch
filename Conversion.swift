//
//  Conversion+CoreDataClass.swift
//  Finch
//
//  Created by Nicholas Bellucci on 12/15/20.
//
//

import Foundation
import CoreData
import Combine

@objc(Conversion)
public class Conversion: NSManagedObject {
    @nonobjc public class func createBlank(context: NSManagedObjectContext) -> AnyPublisher<NSManagedObjectContext, Error> {
        Future<NSManagedObjectContext, Error> { promise in
            let entity = NSEntityDescription.entity(forEntityName: "Conversion", in: context)
            let newConversion = NSManagedObject(entity: entity!, insertInto: context)

            newConversion.setValue(UUID(), forKey: "id")
            newConversion.setValue("New Model", forKey: "name")
            newConversion.setValue("", forKey: "json")
            newConversion.setValue(0, forKey: "language")

            do {
                try context.save()
                promise(.success(context))
            } catch {
                promise(.failure(error))
            }
        }
        .eraseToAnyPublisher()
    }

    @nonobjc public class func fetchAll(context: NSManagedObjectContext) -> AnyPublisher<[Conversion], Error> {
        Future<[Conversion], Error> { promise in
            let request = Conversion.createFetchRequest()
            request.returnsObjectsAsFaults = false

            do {
                let conversions = try context.fetch(request)
                promise(.success(conversions))
            } catch {
                promise(.failure(error))
            }
        }
        .eraseToAnyPublisher()
    }
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
