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

struct HomeView: View {
    let store: Store<HomeDomain.State, HomeDomain.Action>

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
                            send: HomeDomain.Action.setLanguage
                        ),
                        label: Button("Export All") {
                            viewStore.send(.showSave(true))
                        }
                    ) {
                        ForEach(Language.allCases, id: \.self) {
                            Text($0.title)
                                .tag($0)
                        }
                    }
                    .scaledToFit()
                    .pickerStyle(DefaultPickerStyle())
                    .frame(alignment: .trailing)
                }

                HStack(spacing: 20) {
                    SyntaxTextView(
                        text: viewStore.binding(
                            get: \.json,
                            send: HomeDomain.Action.setJSON
                        ),
                        theme: DefaultThemeDark()
                    )
                    .textDidChange { text in
                        viewStore.send(.setJSON(text))
                    }
                    .cornerRadius(5)

                    SyntaxTextView(
                        text: viewStore.binding(
                            get: \.conversion,
                            send: HomeDomain.Action.setConversion
                        ),
                        theme: DefaultThemeDark(),
                        lexer: viewStore.language.lexer
                    )
                    .isEditable(false)
                    .cornerRadius(5)
                }
            }
            .padding(20)
            .background(Color.appBackground)
            .savePanel(
                isPresented: viewStore.binding(
                    get: \.showSave,
                    send: HomeDomain.Action.showSave
                )
            ) { url in
                viewStore.send(.export(url))
            }

        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(
            store: Store(
                initialState: HomeDomain.State(),
                reducer: HomeDomain.reducer,
                environment: HomeDomain.Environment()
            )
        )
        .environment(\.colorScheme, .dark)
        .frame(width: 1000, height: 500)
    }
}
