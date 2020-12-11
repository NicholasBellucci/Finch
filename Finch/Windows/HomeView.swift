//
//  HomeView.swift
//  Finch
//
//  Created by Nicholas Bellucci on 12/10/20.
//

import Core
import Sourceful
import SwiftUI

struct HomeView: SwiftUI.View {
    @State private var json: String = ""
    @State private var swift: String = ""
    @State private var boolean: Bool = false

    var body: some SwiftUI.View {
        HStack(spacing: 20) {
            VStack(alignment: .leading, spacing: 10) {
                Text("JSON")
                    .font(.system(size: 20, weight: .medium))

                SourceCodeTextEditor(
                    text: $json,
                    customization: SourceCodeTextEditor.Customization(
                        didChange: { text in
                            swift = swift(from: text)
                        }
                    )
                )
                .cornerRadius(5)
            }
            .padding([.top, .bottom, .leading], 20)

            VStack(alignment: .leading, spacing: 10) {
                Text("Swift")
                    .font(.system(size: 20, weight: .medium))

                SourceCodeTextEditor(text: $swift)
                    .cornerRadius(5)
            }
            .padding([.top, .bottom, .trailing], 20)
        }
        .background(Color.appBackground)
    }

    func swift(from json: String) -> String {
        if let data = json.data(using: .utf8), let jsonArray = data.serialized() {
            Tree.build(from: jsonArray)
            return Tree.write()
        }

        return ""
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some SwiftUI.View {
        HomeView()
            .environment(\.colorScheme, .dark)
            .frame(width: 1000, height: 500)
    }
}
