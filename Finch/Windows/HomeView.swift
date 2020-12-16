//
//  HomeView.swift
//  Finch
//
//  Created by Nicholas Bellucci on 12/15/20.
//

import ComposableArchitecture
import SwiftUI

struct HomeView: View {
    let store: Store<HomeDomain.State, HomeDomain.Action>

    var body: some View {
        WithViewStore(store) { viewStore in
            NavigationView {
                List {
                    ForEachStore(
                        store.scope(
                            state: \.conversions,
                            action: HomeDomain.Action.conversion(index:_:)
                        ),
                        content: ConversionView.init(store:)
                    )
                }
                .listStyle(SidebarListStyle())
                .onAppear {
                    viewStore.send(.onAppear)
                }
            }
        }
    }
}
