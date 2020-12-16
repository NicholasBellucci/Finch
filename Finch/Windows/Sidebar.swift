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
                    ForEachStore(store.scope(state: \.conversions, action: SidebarDomain.Action.conversion(index:_:)), content: ConversionView.init(store:))

//                    NavigationLink(destination: ConversionView(store: store)) {
//                        Text("gere")
//                    }
                }
                .listStyle(SidebarListStyle())
                .onAppear {
                    viewStore.send(.onAppear)
                }
            }
        }
    }
}
