//
//  SwiftUIView.swift
//  NarratoUI
//
//  Created by Kain Nguyen on 28/3/25.
//

import SwiftUI
import Foundation

public struct ButtonView: View {
    
    public init(action: @escaping () -> Void) {
        self.action = action
    }
    
    var action: () -> Void
    

    public var body: some View {
        VStack {
            Text("NarratoUI")
        }
    }
    
}


#Preview {
    ButtonView(action: {})
}
