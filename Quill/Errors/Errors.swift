//
//  Errors.swift
//  Quill
//
//  Created by Nicholas Bellucci on 12/9/20.
//

import Foundation

extension NSError {
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
