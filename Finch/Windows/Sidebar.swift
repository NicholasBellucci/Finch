//
//  Sidebar.swift
//  Finch
//
//  Created by Nicholas Bellucci on 12/15/20.
//

import ComposableArchitecture
import SwiftUI

struct Sidebar: View {
    let store: Store<SidebarDomain.State, SidebarDomain.Action>

    var body: some View {
        WithViewStore(store) { viewStore in
            NavigationView {
                List {
                    NavigationLink(
                        destination: HomeView(
                            store: store.scope(
                                state: \.homeState,
                                action: SidebarDomain.Action.home
                            )
                        )
                    ) {

                    }
                }
                .listStyle(SidebarListStyle())
                .onAppear {
                    viewStore.send(.onAppear)
                }
            }
        }
    }
}
