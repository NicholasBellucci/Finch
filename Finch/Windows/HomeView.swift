//
//  HomeView.swift
//  Finch
//
//  Created by Nicholas Bellucci on 12/10/20.
//

import Core
import Toucan
import SwiftUI

struct HomeView: View {
    @State private var window: NSWindow?
    @State private var selectedLanguage = 0
    @State private var json: String = ""
    @State private var conversion: String = ""

    private let saveFileNotification = NotificationCenter.default.publisher(for: .saveFile)

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("JSON")
                    .font(.system(size: 20, weight: .medium))

                Spacer()

                Picker(
                    selection: $selectedLanguage,
                    label: Button("Export All") {
                        saveFolder()
                    }
                ) {
                    ForEach(Languages.allCases, id: \.self) {
                        Text($0.title)
                            .tag($0.rawValue)
                    }
                }
                .scaledToFit()
                .pickerStyle(DefaultPickerStyle())
                .frame(alignment: .trailing)
            }

            HStack(spacing: 20) {
                SyntaxTextView(text: $json, theme: DefaultThemeDark())
                    .textDidChange { text in
                        conversion = conversion(from: text)
                    }
                    .cornerRadius(5)

                SyntaxTextView(text: $conversion, theme: DefaultThemeDark())
                    .isEditable(false)
                    .cornerRadius(5)
            }
        }
        .bindWindow($window)
        .padding(20)
        .background(Color.appBackground)
        .onReceive(saveFileNotification) { publisher in
            exportFiles(publisher)
        }
    }

    func conversion(from json: String) -> String {
        if let data = json.data(using: .utf8), let jsonArray = data.serialized() {
            Tree.build(.kotlin, from: jsonArray)
            return Tree.write()
        }

        return ""
    }

    func saveFolder() {
        guard let window = window else { return }

        let panel = NSSavePanel()
        panel.title = ""
        panel.nameFieldLabel = "Export All To:"
        panel.nameFieldStringValue = "Models"
        panel.canCreateDirectories = true
        panel.allowedFileTypes = []
        panel.beginSheetModal(for: window) { response in
            if response == NSApplication.ModalResponse.OK, let fileUrl = panel.url {
                NotificationCenter.default.post(name: .saveFile, object: fileUrl)
            }
        }
    }

    func exportFiles(_ publisher: NotificationCenter.Publisher.Output) {
        guard let fileExtension = Languages(rawValue: selectedLanguage)?.fileExtension else { return }

        if let url = publisher.object as? URL {
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
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environment(\.colorScheme, .dark)
            .frame(width: 1000, height: 500)
    }
}
