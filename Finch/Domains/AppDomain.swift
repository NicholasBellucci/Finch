//
//  AppDomain.swift
//  Finch
//
//  Created by Nicholas Bellucci on 12/14/20.
//

import ComposableArchitecture

struct AppDomain {
    struct State: Equatable {
        var sidebarState = SidebarDomain.State()
    }

    enum Action {
        case sidebar(SidebarDomain.Action)
    }

    struct Environment {
    }

    static let reducer = Reducer<State, Action, Environment>.combine(
        Reducer { _, action, _ in
            switch action {
            case .sidebar: return .none
            }
        },
        SidebarDomain.reducer
            .pullback(
                state: \.sidebarState,
                action: /AppDomain.Action.sidebar,
                environment: { _ in SidebarDomain.Environment() })
    )
}
