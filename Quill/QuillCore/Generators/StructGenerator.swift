import Foundation

struct ConstructionObject: Codable {
    let name: String
    let keys: [String: String]
    let properties: [String: String]
}

struct StructGenerator {
    static var currentNode: String?

    static func generate(with parent: Node) -> ConstructionObject {
        var keys: [String: String] = [:]
        var properties: [String: String] = [:]

        parent.children.forEach { node in
            keys[node.key] = KeyHandler.update(key: node.key)
            properties[node.key] = node.type
        }

        currentNode = parent.name

        return ConstructionObject(name: parent.name, keys: keys, properties: properties)
    }
}
