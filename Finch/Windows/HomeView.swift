//
//  HomeView.swift
//  Finch
//
//  Created by Nicholas Bellucci on 12/10/20.
//

import SwiftUI
import CodeViewer

struct HomeView: View {
    @State private var jsonText = "test"
    @State private var codableText = "test"
    @State private var json = """
        [
          {
            "_id": "5973782bdb9a930533b05cb2",
            "isActive": true,
            "balance": "$1,446.35",
            "age": 32,
            "eyeColor": "green",
            "name": "Logan Keller",
            "gender": "male",
            "company": "ARTIQ",
            "email": "logankeller@artiq.com",
            "phone": "+1 (952) 533-2258",
            "friends": [
              {
                "id": 0,
                "name": "Colon Salazar"
              },
              {
                "id": 1,
                "name": "French Mcneil"
              },
              {
                "id": 2,
                "name": "Carol Martin"
              }
            ],
            "favoriteFruit": "banana"
          }
        ]
        """

    @State private var swift = """
        public struct Friend: Codable {
            public enum CodingKeys: String, CodingKey, CaseIterable {
                case id
                case name
            }

            public var id: Double
            public var name: String

            public init(id: Double, name: String) {
                self.id = id
                self.name = name
            }
        }

        """

    var body: some View {
        HStack(spacing: 20) {
            VStack(alignment: .leading, spacing: 10) {
                Text("JSON")
                    .font(.system(size: 20, weight: .medium))

                CodeViewer(
                    content: $json,
                    mode: .swift,
                    darkTheme: .tomorrow_night,
                    lightTheme: .xcode,
                    fontSize: 13,
                    textDidChanged: nil
                )
                .cornerRadius(5)
            }
            .padding([.top, .bottom, .leading], 20)

            VStack(alignment: .leading, spacing: 10) {
                Text("Swift")
                    .font(.system(size: 20, weight: .medium))

                CodeViewer(
                    content: $swift,
                    mode: .swift,
                    darkTheme: .tomorrow_night,
                    lightTheme: .xcode,
                    fontSize: 13,
                    textDidChanged: nil
                )
                .cornerRadius(5)
            }
            .padding([.top, .bottom, .trailing], 20)
        }
        .background(Color.appBackground)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environment(\.colorScheme, .dark)
            .frame(width: 1000, height: 500)
    }
}
