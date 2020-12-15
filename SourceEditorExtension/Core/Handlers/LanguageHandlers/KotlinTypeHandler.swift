import Foundation

struct KotlinTypeHandler {
    static func detectType(of value: Any) -> Primitive? {
        if value is [[String: Any]] {
            return .custom(.list)
        }

        if let array = value as? Array<Any> {
            guard let item = array.first else { return nil }
            guard let type = detectType(of: item) else { return nil }
            return .list("List<\(type.description)>")
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
