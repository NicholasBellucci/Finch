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

public struct <#ModelName#>: Codable {
    public enum CodingKeys: String, CodingKey, CaseIterable {
        case id = "_id"
        case age
        case balance
        case company
        case email
        case eyeColor
        case favoriteFruit
        case friends
        case gender
        case isActive
        case name
        case phone
    }

    public var id: String
    public var age: Double
    public var balance: String
    public var company: String
    public var email: URL
    public var eyeColor: String
    public var favoriteFruit: String
    public var friends: [Friend]
    public var gender: String
    public var isActive: Bool
    public var name: String
    public var phone: String

    public init(id: String, age: Double, balance: String, company: String, email: URL, eyeColor: String, favoriteFruit: String, friends: [Friend], gender: String, isActive: Bool, name: String, phone: String) {
        self.id = id
        self.age = age
        self.balance = balance
        self.company = company
        self.email = email
        self.eyeColor = eyeColor
        self.favoriteFruit = favoriteFruit
        self.friends = friends
        self.gender = gender
        self.isActive = isActive
        self.name = name
        self.phone = phone
    }
}


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
