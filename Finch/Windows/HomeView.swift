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

                Picker(selection: $selectedLanguage, label: Text("Language")) {
                    ForEach(Languages.allCases, id: \.self) {
                        Text($0.title)
                            .tag($0.rawValue)
                    }
                }
                .labelsHidden()
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
            if let saveUrl = publisher.object as? URL {
                do {
                    try conversion.write(to: saveUrl, atomically: true, encoding: .utf8)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }

    func conversion(from json: String) -> String {
        if let data = json.data(using: .utf8), let jsonArray = data.serialized() {
            Tree.build(from: jsonArray)
            return Tree.write()
        }

        return ""
    }

    func exportFile() {
        guard let window = window,
              let selectedLanguage = Languages(rawValue: selectedLanguage) else { return }

        let panel = NSSavePanel()
        panel.title = ""
        panel.nameFieldLabel = "Save As:"
        panel.nameFieldStringValue = "Untitled"
        panel.canCreateDirectories = true
        panel.allowedFileTypes = [selectedLanguage.fileType]
        panel.beginSheetModal(for: window) { response in
            if response == NSApplication.ModalResponse.OK, let fileUrl = panel.url {
                NotificationCenter.default.post(name: .saveFile, object: fileUrl)
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
