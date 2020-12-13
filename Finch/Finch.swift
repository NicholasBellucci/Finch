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
                .frame(minWidth: 600, maxWidth: .infinity, minHeight: 600, maxHeight: .infinity)
                .navigationTitle("")
                .toolbar {
                    Button(action: {}) {
                        Image(systemName: "gear")
                    }
                }
        }
    }
}
