//
//  ForgotPasswordView.swift
//  NarratoAI
//
//  Created by Kain Nguyen on 31/3/25.
//

import NarratoUI
import SwiftUI

struct ForgotPasswordView: View {
    // In MVVM the Output will be located in the ViewModel
    struct Output {
        var goToForgotPasswordWebsite: () -> Void
    }

    var output: Output

    var body: some View {

        ButtonView(
            action: {
                self.output.goToForgotPasswordWebsite()
            }, title: "Forgot Password")
        .padding()
    
    }
}

#Preview {
    ForgotPasswordView(output: .init(goToForgotPasswordWebsite: {}))
}
