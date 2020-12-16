//
//  ChangeObserver.swift
//  Finch
//
//  Created by Nicholas Bellucci on 12/14/20.
//

import SwiftUI

struct ChangeObserver<Value: Equatable>: ViewModifier {
    var value: Value
    let action: (Value) -> ()

    func body(content: Content) -> some View {
        if #available(OSX 11.0, *) {
            return AnyView(
                content
                    .onChange(of: value) { _ in
                        action(value)
                    }
            )
        } else {
            return AnyView(
                content
                    .onReceive([value].publisher.first()) { _ in
                        action(value)
                    }
            )
        }
    }
}

extension View {
    func onChange<Value: Equatable>(_ value: Value, perform action: @escaping (Value) -> ()) -> some View {
        self.modifier(ChangeObserver(value: value, action: action))
    }
}

