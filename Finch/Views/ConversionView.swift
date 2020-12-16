//
//  HomeView.swift
//  Finch
//
//  Created by Nicholas Bellucci on 12/10/20.
//

import ComposableArchitecture
import Core
import Toucan
import SwiftUI

struct ConversionView: View {
    let store: Store<ConversionDomain.State, ConversionDomain.Action>
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
                            get: \.conversion.json,
                            send: ConversionDomain.Action.setJSON
                        ),
                        theme: DefaultThemeDark()
                    )
                    .isFirstResponder(!isPlaceholder)
                    .textDidChange { text in
                        viewStore.send(.setJSON(text))
                    }
                    .cornerRadius(5)

                    SyntaxTextView(
                        text: viewStore.binding(
                            get: \.convertedString,
                            send: ConversionDomain.Action.setConversion
                        ),
                        theme: DefaultThemeDark(),
                        lexer: viewStore.language.lexer
                    )
                    .isEditable(false)
                    .cornerRadius(5)
                }
            }
            .allowsHitTesting(!isPlaceholder)
            .padding(20)
            .background(Color.appBackground)
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
        }
    }
}

//struct ConversionView_Previews: PreviewProvider {
//    static var previews: some View {
//        ConversionView(
//            store: Store(
//                initialState: ConversionDomain.State(),
//                reducer: ConversionDomain.reducer,
//                environment: ConversionDomain.Environment()
//            )
//        )
//        .environment(\.colorScheme, .dark)
//        .frame(width: 1000, height: 500)
//    }
//}
