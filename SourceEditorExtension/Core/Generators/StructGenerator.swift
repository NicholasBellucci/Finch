import Foundation

typealias ModelInfo = (name: String, keys: [String: String], properties: [String: String])

struct StructGenerator {
    static var currentNode: String?

    static func generate(with parent: Node) -> ModelInfo {
        var keys: [String: String] = [:]
        var properties: [String: String] = [:]

        parent.children.forEach { node in
            keys[node.key] = KeyHandler.update(key: node.key)
            properties[node.key] = node.valueType
        }

        currentNode = parent.name

        return ModelInfo(name: parent.name, keys: keys, properties: properties)
    }
}
