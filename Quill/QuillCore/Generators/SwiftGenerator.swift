import Foundation

struct SwiftGenerator {
    static func generate(with model: ConstructionObject) -> String {
        var swift = ""
        swift += swiftObject(with: model)
        return swift
    }

    private static func swiftObject(with model: ConstructionObject) -> String {
        var swift = "public struct \(model.name): Codable {\n"
        swift += swiftFor(properties: model.properties)
        swift += "}\n"
        return swift
    }

    private static func swiftFor(properties: [String: String]) -> String {
        var swift = ""
        swift += swiftCodingKeys(from: properties.keys.sorted())
        swift += swiftVariables(from: properties)
        swift += swiftInit(from: properties)
        return swift
    }

    private static func swiftCodingKeys(from keys: [String]) -> String {
        var swift = "    public enum CodingKeys: String, CodingKey, CaseIterable {\n"
        keys.forEach { key in
            let newKey = KeyHandler.update(key: key)
            if newKey != key {
                swift += "        case \(newKey) = \"\(key)\"\n"
            } else {
                swift += "        case \(key)\n"
            }
        }
        swift += "    }\n\n"
        return swift
    }

    private static func swiftVariables(from properties: [String: String]) -> String {
        var swift = ""
        for key in properties.keys.sorted() {
            guard let value = properties[key] else { continue }
            swift += "    public var \(KeyHandler.update(key: key)): \(value)\n"
        }
        swift += "\n"
        return swift
    }

    private static func swiftInit(from properties: [String: String]) -> String {
        var swift = ""
        swift += "    public init("
        for (index, key) in properties.keys.sorted().enumerated() {
            guard let value = properties[key] else { continue }
            if index != properties.keys.count - 1 {
                swift += "\(KeyHandler.update(key: key)): \(value), "
            } else {
                swift += "\(KeyHandler.update(key: key)): \(value)"
            }
        }
        swift += ") {\n"
        properties.keys.sorted().forEach { key in
            swift += "        self.\(KeyHandler.update(key: key)) = \(KeyHandler.update(key: key))\n"
        }
        swift += "    }\n"
        return swift
    }
}
