//
//  SwiftUIView.swift
//  NarratoUI
//
//  Created by Kain Nguyen on 31/3/25.
//

import SwiftUI

public struct ButtonView: View {

    public init(action: @escaping () -> Void, title: String = "") {
        self.action = action
        self.title = title
    }

    public var action: () -> Void
    public var title = ""

    public var body: some View {
        Button {
            action()
        } label: {
            Text(title)
        }

    }
}

#Preview {
    ButtonView {}
}
