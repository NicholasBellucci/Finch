//
//  SavePanel.swift
//  Finch
//
//  Created by Nicholas Bellucci on 12/14/20.
//

import SwiftUI

struct SavePanel: ViewModifier {
    @State var window: NSWindow?

    @Binding var isPresented: Bool
    var okAction: (URL) -> ()

    func body(content: Content) -> some View {
        content
            .bindWindow($window)
            .onChange(of: isPresented) { _ in
                save()
            }
    }

    func save() {
        guard let window = window else { return }
        
        let panel = NSSavePanel()
        panel.title = ""
        panel.nameFieldLabel = "Export All To:"
        panel.nameFieldStringValue = "Models"
        panel.canCreateDirectories = true
        panel.allowedFileTypes = []
        panel.beginSheetModal(for: window) { response in
            if response == NSApplication.ModalResponse.OK, let fileUrl = panel.url {
                okAction(fileUrl)
                isPresented = false
            }

            if response == NSApplication.ModalResponse.cancel {
                isPresented = false
            }
        }
    }
}

extension View {
    func savePanel(isPresented: Binding<Bool>, didConfirm: @escaping (URL) -> ()) -> some View {
        self.modifier(SavePanel(isPresented: isPresented, okAction: didConfirm))
    }
}
