import Foundation

extension NSError {
    static var emptyClipboard: NSError {
        NSError(
            domain: "",
            code: 1,
            userInfo: failureReasonInfo(
                title: "Empty Clipboard",
                message: "The clipboard appears empty."
            )
        )
    }

    static var invalidSelection: NSError {
        NSError(
            domain: "",
            code: 1,
            userInfo: failureReasonInfo(
                title: "Selection Invalid",
                message: "The selection is invalid."
            )
        )
    }

    static var malformedJSON: NSError {
        NSError(
            domain: "",
            code: 1,
            userInfo: failureReasonInfo(
                title: "Malformed JSON",
                message: "The copied JSON appears malformed."
            )
        )
    }
}

private extension NSError {
    static func failureReasonInfo(title: String, message: String, comment: String = "") -> [String: Any] {
        [
            NSLocalizedFailureReasonErrorKey: NSLocalizedString(
                title,
                value: message,
                comment: comment
            )
        ]
    }
}
