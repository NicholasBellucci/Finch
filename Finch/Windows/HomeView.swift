//
//  HomeView.swift
//  Finch
//
//  Created by Nicholas Bellucci on 12/10/20.
//

import Combine
import SwiftUI

struct HomeView: View {
    @State private var jsonText = "test"
    @State private var codableText = "test"

    var body: some View {
        HStack(spacing: 20) {
            VStack(alignment: .leading, spacing: 10) {
                Text("JSON")
                    .font(.system(size: 20, weight: .medium))

                ColoredView(color: .appDarkGrey) {
                    TextView(text: $jsonText)
                }
                .cornerRadius(5)
            }
            .padding([.top, .bottom, .leading], 20)

            VStack(alignment: .leading, spacing: 10) {
                Text("Swift")
                    .font(.system(size: 20, weight: .medium))

                ColoredView(color: .appDarkGrey) {
                    TextView(text: $codableText)
                }
                .cornerRadius(5)
            }
            .padding([.top, .bottom, .trailing], 20)
        }
        .background(Color.appBlack)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
