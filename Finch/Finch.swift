//
//  Finch.swift
//  Finch
//
//  Created by Nicholas Bellucci on 12/8/20.
//

import Cocoa
import SwiftUI

var appDelegate = AppDelegate()

@main
struct AppUserInterfaceSelector {
    static func main() {
        if #available(OSX 11.0, *) {
            Finch.main()
        } else {
            FinchOld.main()
        }
    }
}

@available(OSX 11.0, *)
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

struct FinchOld {
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
        let contentView = LandingView()

        window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 800, height: 300),
            styleMask: [.closable, .miniaturizable],
            backing: .buffered, defer: false)
        window.isReleasedWhenClosed = false
        window.center()
        window.setFrameAutosaveName("Main Window")
        window.contentView = NSHostingView(rootView: contentView)
        window.makeKeyAndOrderFront(nil)
    }

    func applicationWillTerminate(_ aNotification: Notification) { }
}
