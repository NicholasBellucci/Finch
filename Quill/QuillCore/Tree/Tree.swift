import Foundation

struct Tree {
    static var rootNode: Node?

    private static var parents: [Node] = []

    static func build(from json: [String: Any]) {
        parents = []
        
        let rootNode = Node(name: String(placeholder: "ModelName"))
        addChildren(to: rootNode, with: json)
        self.rootNode = rootNode

        createNodes()
    }

    static func write() -> String {
        var swift = ""

        parents.forEach {
            $0.generateSwift()

            if let nodeSwift = $0.swift {
                if $0 != parents.first {
                    swift += "\n\n"
                }
                
                swift += nodeSwift
            }
        }

        return swift
    }
}

private extension Tree {
    /**
     Adds children to a parent node.
     Runs recursively if a child node should contain children.

     - Parameters:
        - node: The node to which the children will be added
        - json: The json object related to the node
     */
    static func addChildren(to node: Node, with json: [String: Any]) {
        parents.append(node)

        json.keys.forEach {
            let newNode = Node(key: $0, value: json[$0])
            node.add(child: newNode)

            if let json = json.value(from: $0) {
                addChildren(to: newNode, with: json)
            }
        }
    }

    /**
     Updates the names of every node that has the same name but different children.
     Will not change names of root node children as these are named after json files.

     "foo": {
        "bal": {
            "bar": "quuz",
            "baz": "norf",
            "baq": "duif"
        }
     }

     "faa": {
        "baf": "quuz",
        "bao": "norf",
        "bal": {
            "bar": "quuz",
            "baz": "norf"
        }
     }

     Resulting Tree:

     - Foo
        - FooBal
     - Faa
        - Baf
        - Bao
        - FaaBal

     */
    static func createNodes() {
        let dictionary = Dictionary(grouping: parents, by: { $0.name })

        dictionary.keys.forEach {
            if let nodes = dictionary[$0], nodes.count > 1 {
                nodes.uniqueElements
                    .filter { $0.parent != nil && $0.parent != rootNode }
                    .forEach {
                        $0.name = "\($0.parent!.name)\($0.name)"
                        $0.updateType()
                }
            }
        }
    }
}
