//
//  Finch.swift
//  Finch
//
//  Created by Nicholas Bellucci on 12/8/20.
//

import Cocoa
import ComposableArchitecture
import CoreData
import SwiftUI

@main
struct Finch: App {
    @State private var window: NSWindow?
    var appStore = Store(initialState: AppDomain.State(), reducer: AppDomain.reducer, environment: AppDomain.Environment())

    var body: some Scene {
        WindowGroup {
            HomeView(store: appStore.scope(state: \.homeState, action: AppDomain.Action.home))
                .navigationTitle("Untitled Model")
        }
        .commands {
            SidebarCommands()
        }
    }
}
