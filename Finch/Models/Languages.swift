//
//  Languages.swift
//  Finch
//
//  Created by Nicholas Bellucci on 12/14/20.
//

import Foundation
import Core

public enum Language: Int, CaseIterable {
    case swift
    case kotlin

    var title: String {
        switch self {
        case .swift: return "Swift"
        case .kotlin: return "Kotlin"
        }
    }

    var fileExtension: String {
        switch self {
        case .swift: return "swift"
        case .kotlin: return "kt"
        }
    }

    var generatorType: GeneratorType {
        switch self {
        case .swift: return .swift
        case .kotlin: return .kotlin
        }
    }
}
