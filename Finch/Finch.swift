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

var appDelegate = AppDelegate()
var appStore = Store(
    initialState: AppDomain.State(),
    reducer: AppDomain.reducer,
    environment: AppDomain.Environment()
)

@main
struct AppUserInterfaceSelector {
    static func main() {
        if #available(OSX 11.0, *) {
            Finch.main()
        } else {
            FinchAppDelegate.main()
        }
    }
}

@available(OSX 11.0, *)
struct Finch: App {
    @State private var window: NSWindow?
    let persistenceController = PersistenceController.shared

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

struct FinchAppDelegate {
    static func main() {
        NSApplication.shared.setActivationPolicy(.regular)

        NSApp.delegate = appDelegate
        NSApp.activate(ignoringOtherApps: true)
        NSApp.run()
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    var window: NSWindow!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let contentView = HomeView(store: appStore.scope(state: \.homeState, action: AppDomain.Action.home))

        window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 800, height: 300),
            styleMask: [.closable, .miniaturizable],
            backing: .buffered, defer: false)
        window.isReleasedWhenClosed = false
        window.center()
        window.setFrameAutosaveName("")
        window.contentView = NSHostingView(rootView: contentView)
        window.makeKeyAndOrderFront(nil)
    }

    func applicationWillTerminate(_ aNotification: Notification) { }
}
