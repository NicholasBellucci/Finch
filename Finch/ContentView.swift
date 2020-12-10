//
//  ContentView.swift
//  Finch
//
//  Created by Nicholas Bellucci on 12/8/20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack(spacing: 30) {
            Image("finch.icon")
                .resizable()
                .frame(width: 200, height: 200)

            VStack(alignment: .leading, spacing: 10) {
                Text("Finch")
                    .font(.system(size: 40, weight: .medium))

                Text("An Xcode source extension for quickly creating Codable models from JSON.")
                    .font(.system(size: 17, weight: .regular))
                    .lineSpacing(5)

                Spacer()

                VStack(alignment: .leading, spacing: 15) {
                    Text("To enable open System Preferences > Extensions > Xcode Source Editor")
                        .font(.system(size: 13, weight: .regular))
                        .lineSpacing(5)

                    Button("Open System Preferences") {
                        if let url = URL(string: "x-apple.systempreferences:com.apple") {
                            NSWorkspace.shared.open(url)
                        }
                    }
                }
                .padding(.bottom, 10)
            }
            .frame(maxHeight: 200)
        }
        .padding(50)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
