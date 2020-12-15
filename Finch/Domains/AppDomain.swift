import ComposableArchitecture

struct AppDomain {
    struct State: Equatable {
        var homeState = HomeDomain.State()
    }

    enum Action {
        case home(HomeDomain.Action)
    }

    struct Environment {
    }

    static let reducer = Reducer<State, Action, Environment>.combine(
        Reducer { _, action, _ in
            switch action {
            case .home: return .none
            }
        },
        HomeDomain.reducer
            .pullback(
                state: \.homeState,
                action: /AppDomain.Action.home,
                environment: { _ in HomeDomain.Environment() })
    )
}
