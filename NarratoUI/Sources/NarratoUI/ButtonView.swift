//
//  SwiftUIView.swift
//  NarratoUI
//
//  Created by Kain Nguyen on 31/3/25.
//

import SwiftUI

public struct ButtonView: View {
    
    public init(action: @escaping () -> Void) {
        self.action = action
    }
    
    public var action: () -> Void

    public var body: some View {
        Button {
            action()
        } label: {
            Text("Text View")
        }

    }
}

#Preview {
    ButtonView {}
}
