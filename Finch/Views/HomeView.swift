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
            if #available(OSX 11.0, *) {
                NavigationView {
                    List(selection: viewStore.binding(get: \.selectedId, send: HomeDomain.Action.selectConversion)) {
                        ForEachStore(
                            store.scope(
                                state: \.conversions,
                                action: HomeDomain.Action.conversion(index:action:)
                            )
                        ) { store in
                            SidebarCell(
                                store: store,
                                selection: viewStore.binding(
                                    get: \.selectedId,
                                    send: HomeDomain.Action.selectConversion
                                )
                            )
                        }
                    }
                    .listStyle(SidebarListStyle())
                }
                .onAppear {
                    viewStore.send(.onAppear)
                }
                .toolbar {
                    Button(action: { viewStore.send(.deleteAll) }) {
                        Image(systemName: "gear")
                    }
                }
            } else {
                // Fallback on earlier versions
            }
        }
    }
}

private struct SidebarCell: View {
    let store: Store<ConversionDomain.State, ConversionDomain.Action>
    @Binding var selection: String?

    var body: some View {
        WithViewStore(store) { viewStore in
            NavigationLink(
                destination: ConversionView(store: store),
                tag: viewStore.id,
                selection: $selection,
                label: {
                    Text(viewStore.conversion.name)
                        .frame(maxWidth: .infinity)
                }
            )
        }
    }
}
