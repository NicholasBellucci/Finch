//
//  SidebarDomain.swift
//  Finch
//
//  Created by Nicholas Bellucci on 12/15/20.
//

import ComposableArchitecture
import Cocoa
import Core

struct SidebarDomain {
    struct State: Equatable {
        var conversions: [ConversionDomain.State] = []
    }

    enum Action: Equatable {
        case conversion(index: Int, _ action: ConversionDomain.Action)
        case onAppear
    }

    struct Environment {
        var viewContext: NSManagedObjectContext = PersistenceController.shared.container.viewContext
    }

    static let reducer = Reducer<State, Action, Environment> { state, action, environment in
        switch action {
        case .conversion:
            return .none
        case .onAppear:
//            let entity = NSEntityDescription.entity(forEntityName: "Conversion", in: context)
//            let newConversion = NSManagedObject(entity: entity!, insertInto: context)
//
//            newConversion.setValue("Test", forKey: "name")
//            newConversion.setValue("{\"id\":\"1\"}", forKey: "json")
//
//            do {
//                try context.save()
//            } catch {
//               print("Failed saving")
//            }
            let request = Conversion.createFetchRequest()
            request.returnsObjectsAsFaults = false

            do {
                let conversions = try environment.viewContext.fetch(request)
                state.conversions = conversions.map { ConversionDomain.State(conversion: $0) }
            } catch {
                print("Failed")
            }

            return .none
        }
    }
}
