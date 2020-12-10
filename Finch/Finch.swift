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
            LandingView()
                .frame(width: 800, height: 300)
        }
        .windowStyle(HiddenTitleBarWindowStyle())
    }
}

struct FinchOld {
    static func main() {
        NSApplication.shared.setActivationPolicy(.regular)

        let nib = NSNib(nibNamed: NSNib.Name("MainMenu"), bundle: Bundle.main)
        nib?.instantiate(withOwner: NSApplication.shared, topLevelObjects: nil)

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
            styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
            backing: .buffered, defer: false)
        window.isReleasedWhenClosed = false
        window.center()
        window.setFrameAutosaveName("Main Window")
        window.contentView = NSHostingView(rootView: contentView)
        window.makeKeyAndOrderFront(nil)
    }

    func applicationWillTerminate(_ aNotification: Notification) { }
}
