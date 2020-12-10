//
//  ContentView.swift
//  Finch
//
//  Created by Nicholas Bellucci on 12/8/20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack {
            Image("finch.icon")
                .resizable()
                .frame(width: 300, height: 300)

            VStack(alignment: .leading) {
                Text("Finch")
                    .font(.system(size: 40, weight: .medium))

                Button("Open Settings") {
                    let url = URL(string: "x-apple.systempreferences:com.apple")!
                    NSWorkspace.shared.open(url)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
