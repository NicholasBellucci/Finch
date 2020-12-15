//
//  Languages.swift
//  Finch
//
//  Created by Nicholas Bellucci on 12/14/20.
//

import Foundation

public enum Languages: Int, CaseIterable {
    case swift
    case kotlin

    var title: String {
        switch self {
        case .swift: return "Swift"
        case .kotlin: return "Kotlin"
        }
    }

    var fileType: String {
        switch self {
        case .swift: return "swift"
        case .kotlin: return "kt"
        }
    }
}
