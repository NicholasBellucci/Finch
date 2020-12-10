import Foundation

enum Primitive {
    case array(String), custom(CustomType)
    case bool, date, double, int, string, url, any

    var description: String {
        switch self {
        case .array: return "Array"
        case .bool: return "Bool"
        case .date: return "Date"
        case .double: return "Double"
        case .int: return "Int"
        case .string: return "String"
        case .url: return "URL"
        case .any: return String(placeholder: "Any")
        case .custom: return "Custom"
        }
    }
}

enum CustomType {
    case object
    case array
}

struct TypeHandler {
    static func detectType(of value: Any) -> Primitive? {
        if value is [[String: Any]] {
            return .custom(.array)
        }

        if let array = value as? Array<Any> {
            guard let item = array.first else { return nil }
            guard let type = detectType(of: item) else { return nil }
            return .array("[\(type.description)]")
        }

        if value is [String: Any] {
            return .custom(.object)
        }

        if let x = value as? NSNumber {
            if x === NSNumber(value: true) || x === NSNumber(value: false) {
                return .bool
            }
        }

        if value is Double {
            return .double
        }

        if value is Int {
            return .int
        }

        if let string = value as? String {
            if isURL(string) {
                return .url
            }

            if isDate(string) {
                return .date
            }

            return .string
        }

        return .any
    }

    static func isURL(_ string: String) -> Bool {
        guard let detector = try? NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue) else { return false }
        if let match = detector.firstMatch(in: string, options: [], range: NSRange(location: 0, length: string.endIndex.utf16Offset(in: string))) {
            return match.range.length == string.endIndex.utf16Offset(in: string)
        } else {
            return false
        }
    }

    static func isDate(_ string: String) -> Bool {
        if DateFormatter.iso8601.date(from: string) != nil {
            return true
        }

        if DateFormatter.dateAndTime.date(from: string.replacingOccurrences(of: "+00:00", with: "")) != nil {
            return true
        }

        if DateFormatter.dateOnly.date(from: string) != nil {
            return true
        }

        return false
    }
}