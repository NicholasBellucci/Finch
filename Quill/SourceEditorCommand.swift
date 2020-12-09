import Cocoa
import Foundation
import XcodeKit

class SourceEditorCommand: NSObject, XCSourceEditorCommand {
    func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void) -> Void {
        guard let selection = invocation.buffer.selections.firstObject as? XCSourceTextRange,
              let copiedString = NSPasteboard.general.pasteboardItems?.first?.string(forType: .string) else { return }

        guard let jsonArray = serialize(data: copiedString.data(using: .utf8)!) else {
            return
        }

        Tree.build(from: jsonArray)
        invocation.buffer.lines.insert(Tree.write(), at: selection.start.line)

        completionHandler(nil)
    }
}

private extension SourceEditorCommand {
    /**
     Serializes the JSON data from a file.

     Will first check for a single key value pair object.
     If that fails it will look for an array of key value pairs and take use the first object.

     - Parameter data: The JSON data created
     */
    func serialize(data: Data) -> [String: Any]? {
        var object: Any?

        do {
            object = try JSONSerialization.jsonObject(with: data, options : .allowFragments)
        } catch {
            print("Error writing file: \(error.localizedDescription)")
        }

        if let json = object as? [String: Any] ?? (object as? [[String: Any]])?.first {
            return json
        }

        return nil
    }
}
