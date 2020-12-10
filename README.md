<img src="https://github.com/NicholasBellucci/Finch/blob/main/Icons/finch.logo.png" width="150"/>

# Finch

A lightweight Xcode source extension that assists in transforming JSON into Codable Swift models. 
Finch will take care of everything. This includes creating a top level model, children models, and declaring the proper types and coding keys. Any unknown types will be generated as placeholder `Any` types.

## Roadmap

- [ ] Support OSX 10.15
- [ ] Add customization settings in the desktop app
- [ ] Add option for custom encode/decode initializers
- [ ] Add Objective-C language option

## Usage
Finch works with your clipboard to create the necessary models. All you need to do is copy some JSON, return to Xcode, and choose `Editor` > `Finch` > `Convert JSON to Codables` from the menu bar. A keyboard shortcut for this command can be set in Xcode `Preferences` > `Key Bindings` > `Convert JSON to Codables`

## Example
### JSON
```json
[
  {
    "_id": "5973782bdb9a930533b05cb2",
    "balance": "$1,446.35",
    "age": 32,
    "name": "Logan Keller",
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
      }
    ]
  }
]
```
### Swift
```swift
public struct <#ModelName#>: Codable {
    public enum CodingKeys: String, CodingKey, CaseIterable {
        case id = "_id"
        case age
        case balance
        case email
        case friends
        case name
        case phone
    }

    public var id: String
    public var age: Double
    public var balance: String
    public var email: URL
    public var friends: [Friend]
    public var name: String
    public var phone: String

    public init(id: String, age: Double, balance: String, email: URL, friends: [Friend], name: String, phone: String) {
        self.id = id
        self.age = age
        self.balance = balance
        self.email = email
        self.friends = friends
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
```

## License

Finch is, and always will be, MIT licensed. See [LICENSE](LICENSE) for details.
