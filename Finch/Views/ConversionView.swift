//
//  HomeView.swift
//  Finch
//
//  Created by Nicholas Bellucci on 12/10/20.
//

import ComposableArchitecture
import Core
import SwiftUI
import Toucan

struct ConversionView: View {
    let store: Store<ConversionDomain.Conversion, ConversionDomain.Action>
    var isPlaceholder: Bool = false

    var body: some View {
        WithViewStore(store) { viewStore in
            VStack(alignment: .leading) {
                HStack {
                    Text("JSON")
                        .font(.system(size: 20, weight: .medium))

                    Spacer()

                    Picker(
                        selection: viewStore.binding(
                            get: \.language,
                            send: ConversionDomain.Action.setLanguage
                        ),
                        label: Text("Select Language")
                    ) {
                        ForEach(Language.allCases, id: \.self) {
                            Text($0.title)
                                .tag($0)
                        }
                    }
                    .labelsHidden()
                    .scaledToFit()
                    .pickerStyle(DefaultPickerStyle())
                    .frame(alignment: .trailing)
                }

                HStack(spacing: 20) {
                    SyntaxTextView(
                        text: viewStore.binding(
                            get: \.json,
                            send: ConversionDomain.Action.setJSON
                        ),
                        theme: viewStore.binding(
                            get: \.theme,
                            send: ConversionDomain.Action.setTheme
                        )
                    )
                    .isFirstResponder(!isPlaceholder)
                    .textDidChange { text in
                        viewStore.send(.setJSON(text))
                    }
                    .cornerRadius(5)

                    SyntaxTextView(
                        text: viewStore.binding(
                            get: \.model,
                            send: ConversionDomain.Action.setModel
                        ),
                        theme: viewStore.binding(
                            get: \.theme,
                            send: ConversionDomain.Action.setTheme
                        ),
                        lexer: viewStore.language.lexer
                    )
                    .isEditable(false)
                    .cornerRadius(5)
                }
            }
            .allowsHitTesting(!isPlaceholder)
            .padding(20)
            .savePanel(
                isPresented: viewStore.binding(
                    get: \.showSave,
                    send: ConversionDomain.Action.showSave
                )
            ) { url in
                viewStore.send(.export(url))
            }
            .onTapGesture {
                viewStore.send(.didBeginEditing)
            }
            .toolbar {
                ToolbarItem(placement: ToolbarItemPlacement.navigation) {
                    TextField(
                        "New Model",
                        text: viewStore.binding(
                            get: \.name,
                            send: ConversionDomain.Action.setName
                        )
                    )
                    .truncationMode(.tail)
                    .frame(width: 400)
                    .font(.system(size: 16, weight: .medium))
                    .textFieldStyle(PlainTextFieldStyle())
                }

                ToolbarItem(placement: ToolbarItemPlacement.status) {
                    Button {
                        
                    } label: {
                        Image(systemName: "gear")
                    }
                }
            }
        }
    }
}

struct ConversionView_Previews: PreviewProvider {
    static var previews: some View {
        ConversionView(
            store: Store(
                initialState: ConversionDomain.Conversion(
                    id: UUID().uuidString,
                    name: "Preview Model",
                    json: "{\n\t\"id\": \"1234\"\n}",
                    model: "public class Test {\n\n}",
                    language: .swift
                ),
                reducer: ConversionDomain.reducer,
                environment: ConversionDomain.Environment()
            )
        )
        .environment(\.colorScheme, .dark)
        .frame(width: 1000, height: 500)
    }
}
