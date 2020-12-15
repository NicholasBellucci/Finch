//
//  WindowAccessor.swift
//  Finch
//
//  Created by Nicholas Bellucci on 12/14/20.
//

import Cocoa
import SwiftUI

public extension View {
    func bindWindow(_ window: Binding<NSWindow?>) -> some View {
        return background(WindowAccessor(window))
    }
}

public struct WindowAccessor: NSViewRepresentable {
    @Binding public var window: NSWindow?

    public init(_ window: Binding<NSWindow?>) {
       _window = window
    }

    public func makeNSView(context: Context) -> NSView {
        return WindowAccessorView($window)
    }

    public func updateNSView(_ nsView: NSView, context: Context) {}
}

class WindowAccessorView: NSView {
    @Binding var windowBinding: NSWindow?

    required init(_ window: Binding<NSWindow?>) {
        _windowBinding = window
        super.init(frame: .zero)
    }

    override func viewDidMoveToWindow() {
        super.viewDidMoveToWindow()
        windowBinding = window
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
