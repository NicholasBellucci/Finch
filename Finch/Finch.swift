//
//  Finch.swift
//  Finch
//
//  Created by Nicholas Bellucci on 12/8/20.
//

import SwiftUI

@main
struct Finch: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
                .frame(minWidth: 300, maxWidth: .infinity, minHeight: 300, maxHeight: .infinity)
        }
        .windowStyle(HiddenTitleBarWindowStyle())
    }
}
