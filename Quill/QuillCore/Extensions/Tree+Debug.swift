import Foundation

extension Tree {
    static var description: String {
        guard let rootNode = rootNode else { return "" }
        var structure = ""
        structure += rootNode.key != "" ? "- \(rootNode.name), 🔑 = \(rootNode.key)" : "- \(rootNode.name)"
        structure += rootNode.type != nil ? " 💰 = \(rootNode.type!)\n" : "\n"
        structure += structureForChildren(on: rootNode)
        return structure
    }
}

private extension Tree {
    static func structureForChildren(on node: Node) -> String {
        var structure = ""
        node.children.sorted(by: { $0.name < $1.name }).forEach { child in
            structure += String(repeating: "\t", count: child.level)
            structure += child.key != "" ? "- \(child.name), 🔑 = \(child.key)" : "- \(child.name)"
            structure += child.type != nil ? " 💰 = \(child.type!)\n" : "\n"
            structure += structureForChildren(on: child)
        }
        return structure
    }
}
