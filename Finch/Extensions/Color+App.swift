//
//  Color+App.swift
//  Finch
//
//  Created by Nicholas Bellucci on 12/10/20.
//

import SwiftUI

extension Color {
    static var appBackground: Color {
        Color("AppBackground")
    }

    static var appBackgroundLight: Color {
        Color("AppBackgroundLight")
    }
}

extension NSColor {
    static var appBackground: NSColor {
        #colorLiteral(red: 0.1137254902, green: 0.1176470588, blue: 0.1411764706, alpha: 1)
    }

    static var appBackgroundLight: NSColor {
        #colorLiteral(red: 0.1647058824, green: 0.1647058824, blue: 0.1882352941, alpha: 1)
    }
}
