//
//  HomeDomain.swift
//  Finch
//
//  Created by Nicholas Bellucci on 12/14/20.
//

import ComposableArchitecture
import Cocoa
import Core
import Toucan

struct ConversionDomain {
    struct Conversion: Equatable, Identifiable, Hashable {
        var id: String
        var name: String
        var json: String
        var model: String
        var language: Language

        var showSave: Bool = false
        var theme: Theme = DefaultThemeDark()
    }

    enum Action: Equatable {
        case didBeginEditing
        case export(URL)
        case onAppear
        case save
        case setJSON(String)
        case setLanguage(Language)
        case setModel(String)
        case setName(String)
        case setTheme(Theme)
        case showSave(Bool)
    }

    struct Environment {
    }

    static let reducer = Reducer<Conversion, Action, Environment> { state, action, _ in
        switch action {
        case .didBeginEditing:
            return .none
        case .export(let url):
            let fileExtension = state.language.fileExtension

            let fileManager = FileManager.default
            if !fileManager.fileExists(atPath: url.path) {
                do {
                    try fileManager.createDirectory(atPath: url.path, withIntermediateDirectories: true, attributes: nil)

                    Tree.forEach {
                        let fileURL = url.appendingPathComponent("\($0.name).\(fileExtension)")
                        do {
                            try $0.model.write(to: fileURL, atomically: true, encoding: .utf8)
                        } catch {
                            print(error.localizedDescription)
                        }
                    }
                } catch {
                    print(error)
                }
            } else {
                print("Folder already exists")
            }

            return .none
        case .onAppear:
            return .none
        case .save:
            return .none
        case .setModel(let string):
            state.model = string
            return Effect(value: .save)
        case .setJSON(let string):
            state.json = string
            return Effect(value: .setModel(convert(json: state.json, language: state.language)))
        case .setLanguage(let language):
            state.language = language
            return Effect(value: .setModel(convert(json: state.json, language: state.language)))
        case .setName(let value):
            state.name = value

            return .merge(
                Effect(
                    value: .setModel(
                        convert(
                            json: state.json,
                            name: String(value.capitalized.filter { !" ".contains($0) }),
                            language: state.language
                        )
                    )
                ),
                Effect(value: .save)
            )
        case .setTheme(let theme):
            state.theme = theme
            return .none
        case .showSave(let value):
            state.showSave = value
            return .none
        }
    }

    static func convert(json: String, name: String = "", language: Language) -> String {
        if let data = json.data(using: .utf8), let jsonArray = data.serialized() {
            if name != "" {
                Tree.build(language.generatorType, name: name, from: jsonArray)
            } else {
                Tree.build(language.generatorType, from: jsonArray)
            }
        }

        return Tree.write()
    }
}
