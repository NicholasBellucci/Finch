//
//  ColoredView.swift
//  Finch
//
//  Created by Nicholas Bellucci on 12/10/20.
//

import SwiftUI

struct ColoredView<Content: View>: View {
    let color: Color
    let content: Content

    private var cornerRadius: CGFloat = 0

    init(color: Color, @ViewBuilder _ content: () -> Content) {
        self.color = color
        self.content = content()
    }

    var body: some View {
        Group {
            content
        }
        .background(
            color
                .cornerRadius(cornerRadius)
        )
    }
}

extension ColoredView {
    func cornerRadius(_ value: CGFloat) -> ColoredView {
        var copy = self
        copy.cornerRadius = value
        return copy
    }
}


