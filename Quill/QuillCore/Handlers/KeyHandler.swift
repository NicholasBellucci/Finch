import Foundation

struct KeyHandler {
    static func update(key: String) -> String {
        let characterSet = Set("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ1234567890_")
        var newKey = key.filter { characterSet.contains($0) }

        if let char = newKey.first, let _ = Int(String(char)) {
            newKey = newKey.camelCased()
            return "_\(newKey)"
        }

        if swiftKeywords.contains(newKey) {
            return "`\(newKey)`"
        }

        if newKey.contains("_") {
            return newKey.camelCased()
        }

        return newKey
    }
}

private extension KeyHandler {
    static let swiftKeywords: Set<String> = [
        "Any",
        "as",
        "associatedtype",
        "break",
        "case",
        "catch",
        "class",
        "continue",
        "default",
        "defer",
        "deinit",
        "do",
        "else",
        "enum",
        "extension",
        "fallthrough",
        "false",
        "fileprivate",
        "for",
        "func",
        "guard",
        "if",
        "import",
        "in",
        "init",
        "inout",
        "internal",
        "is",
        "let",
        "nil",
        "open",
        "operator",
        "private",
        "protocol",
        "public",
        "repeat",
        "rethrows",
        "return",
        "Self",
        "self",
        "static",
        "struct",
        "subscript",
        "super",
        "switch",
        "Type",
        "throw",
        "throws",
        "true",
        "try",
        "typealias",
        "var",
        "where",
        "while"
    ]
}
