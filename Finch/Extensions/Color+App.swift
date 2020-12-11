//
//  Color+App.swift
//  Finch
//
//  Created by Nicholas Bellucci on 12/10/20.
//

import SwiftUI

extension Color {
    static var appBlack: Color {
        Color(.appBlack)
    }

    static var appDarkGrey: Color {
        Color(.appDarkGrey)
    }
}

extension NSColor {
    static var appBlack: NSColor {
        #colorLiteral(red: 0.1137254902, green: 0.1176470588, blue: 0.1411764706, alpha: 1)
    }

    static var appDarkGrey: NSColor {
        #colorLiteral(red: 0.1647058824, green: 0.1647058824, blue: 0.1882352941, alpha: 1)
    }
}
