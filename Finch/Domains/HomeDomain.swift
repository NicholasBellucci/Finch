import ComposableArchitecture
import Cocoa
import Core

struct HomeDomain {
    struct State: Equatable {
        var conversion: String = ""
        var showSave: Bool = false
        var json: String = ""
        var language: Language = .swift
    }

    enum Action: Equatable {
        case export(URL)
        case onAppear
        case setConversion(String)
        case setJSON(String)
        case setLanguage(Language)
        case showSave(Bool)
    }

    struct Environment {
    }

    static let reducer = Reducer<State, Action, Environment> { state, action, _ in
        switch action {
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
        case .setConversion(let string):
            state.conversion = string
            return .none
        case .setJSON(let string):
            state.json = string
            return Effect(value: .setConversion(convert(json: state.json, with: state.language)))
        case .setLanguage(let language):
            state.language = language
            return Effect(value: .setConversion(convert(json: state.json, with: state.language)))
        case .showSave(let value):
            state.showSave = value
            return .none
        }
    }

    static func convert(json: String, with language: Language) -> String {
        if let data = json.data(using: .utf8), let jsonArray = data.serialized() {
            Tree.build(language.generatorType, from: jsonArray)
            return Tree.write()
        }

        return ""
    }
}
