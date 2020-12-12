import Cocoa
import Foundation
import Toucan

public struct XcodeDarkTheme: CodeTheme {
    public init() { }

    public var backgroundColor: NSColor {
        NSColor(red: 42/255.0, green: 42/255, blue: 48/255, alpha: 1.0)
    }

    public var font: NSFont {
        .monospacedSystemFont(ofSize: 13, weight: .medium)
    }

    public var gutterStyle: GutterStyle {
        GutterStyle(backgroundColor: NSColor(red: 42/255.0, green: 42/255, blue: 48/255, alpha: 1.0), minimumWidth: 32)
    }

    public var lineNumbersStyle: LineNumbersStyle {
        LineNumbersStyle(font: .monospacedSystemFont(ofSize: 13, weight: .medium), textColor: lineNumbersColor)
    }

    private var lineNumbersColor: NSColor {
        NSColor(red: 100/255, green: 100/255, blue: 100/255, alpha: 1)
    }

    public func color(for syntaxColorType: TokenType) -> NSColor {
        switch syntaxColorType {
        case .comment:
            return NSColor(red: 69/255, green: 187/255, blue: 62/255, alpha: 1)
        case .customType:
            return NSColor(red: 158/255, green: 241/255, blue: 221/255, alpha: 1)
        case .identifier:
            return NSColor(red: 208/255, green: 168/255, blue: 255/255, alpha: 1)
        case .instanceVariable:
            return NSColor(red: 103/255, green: 183/255, blue: 164/255, alpha: 1)
        case .keyword:
            return NSColor(red: 252/255, green: 95/255, blue: 163/255, alpha: 1)
        case .number:
            return NSColor(red: 116/255, green: 109/255, blue: 176/255, alpha: 1)
        case .other:
            return NSColor(red: 65/255, green: 161/255, blue: 192/255, alpha: 1)
        case .placeholder:
            return backgroundColor
        case .plain:
            return .white
        case .string:
            return NSColor(red: 252/255, green: 106/255, blue: 93/255, alpha: 1)
        case .type:
            return NSColor(red: 93/255, green: 216/255, blue: 255/255, alpha: 1)
        }
    }
}

extension NSColor {
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }

   convenience init(_ hex: Int) {
       self.init(
           red: (hex >> 16) & 0xFF,
           green: (hex >> 8) & 0xFF,
           blue: hex & 0xFF
       )
   }
}
