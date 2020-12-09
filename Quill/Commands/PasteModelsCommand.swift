import Cocoa
import Foundation
import XcodeKit

class PasteModelsCommand: NSObject, XCSourceEditorCommand {
    func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void) -> Void {
        guard let selection = invocation.buffer.selections.firstObject as? XCSourceTextRange else {
            completionHandler(NSError.invalidSelection)
            return
        }

        guard let copiedString = NSPasteboard.general.pasteboardItems?.first?.string(forType: .string) else {
            completionHandler(NSError.emptyClipboard)
            return
        }

        guard let data = copiedString.data(using: .utf8),
              let jsonArray = data.serialized() else {
            completionHandler(NSError.malformedJSON)
            return
        }

        Tree.build(from: jsonArray)
        invocation.buffer.lines.insert(Tree.write(), at: selection.start.line)

        completionHandler(nil)
    }
}
