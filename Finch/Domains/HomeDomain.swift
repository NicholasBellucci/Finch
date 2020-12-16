//
//  SidebarDomain.swift
//  Finch
//
//  Created by Nicholas Bellucci on 12/15/20.
//

import ComposableArchitecture
import Cocoa
import Core
import Combine

struct HomeDomain {
    struct State: Equatable {
        var conversions: [ConversionDomain.State] = []
        var selectedId: String?
    }

    enum Action: Equatable {
        case conversion(index: Int, action: ConversionDomain.Action)
        case createBlankConversion
        case fetchAllConversions
        case onAppear
        case selectConversion(String?)
        case setConversions([Conversion])

        case deleteAll
    }

    struct Environment {
        var mainQueue: AnySchedulerOf<DispatchQueue> = DispatchQueue.main.eraseToAnyScheduler()
        var viewContext: NSManagedObjectContext = PersistenceController.shared.container.viewContext
    }

    static let reducer = Reducer<State, Action, Environment>.combine(
        Reducer { state, action, environment in
            switch action {
            case .conversion:
                return .none
            case .createBlankConversion:
                return Conversion.createBlank(context: environment.viewContext)
                    .flatMap(
                        scheduler: environment.mainQueue,
                        success: { _ in
                            return Effect(value: .fetchAllConversions)
                        },
                        failure: { _ in
                            return .none
                        }
                    )

            case .fetchAllConversions:
                return Conversion.fetchAll(context: environment.viewContext)
                    .flatMap(
                        scheduler: environment.mainQueue,
                        success: { conversions in
                            return Effect(value: .setConversions(conversions))
                        },
                        failure: { _ in
                            return .none
                        }
                    )

            case .onAppear:
                return Effect(value: .fetchAllConversions)
            case .selectConversion(let value):
                state.selectedId = value
                return .none
            case .setConversions(let conversions):
                state.conversions = conversions.map { ConversionDomain.State(conversion: $0) }
                state.selectedId = state.conversions.first?.id

                if state.conversions.isEmpty {
                    return Effect(value: .createBlankConversion)
                } else {
                    return .none
                }
            case .deleteAll:
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Conversion")
                    fetchRequest.returnsObjectsAsFaults = false

                do {
                    let items = try environment.viewContext.fetch(fetchRequest) as! [NSManagedObject]

                    for item in items {
                        if item == items.first {
                            environment.viewContext.delete(item)
                        }

                    }

                    state.conversions = []
                    try environment.viewContext.save()
                } catch {
                    // Error Handling
                    // ...
                }

                return Effect(value: .fetchAllConversions)
            }
        },
        ConversionDomain.reducer.forEach(
            state: \State.conversions,
            action: /Action.conversion(index:action:),
            environment: { _ in ConversionDomain.Environment() })
    )
}
