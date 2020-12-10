//
//  FinchApp.swift
//  Finch
//
//  Created by Nicholas Bellucci on 12/8/20.
//

import SwiftUI

@main
struct Finch: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .frame(width: 800, height: 300)
        }
        .windowStyle(HiddenTitleBarWindowStyle())
    }
}
