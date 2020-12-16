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
        var homeState = HomeDomain.State()
    }

    enum Action: Equatable {
        case home(HomeDomain.Action)
        case onAppear
    }

    struct Environment {
        var viewContext: NSManagedObjectContext = PersistenceController.shared.container.viewContext
    }

    static let reducer = Reducer<State, Action, Environment> { state, action, environment in
        switch action {
        case .home:
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

            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Conversions")
            request.returnsObjectsAsFaults = false

            do {
                let result = try environment.viewContext.fetch(request)
                for data in result as! [NSManagedObject] {
                    print(data.value(forKey: "name") as? String)
                }
            } catch {

                print("Failed")
            }


            return .none
        }
    }
}

