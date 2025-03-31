//
//  LoginView.swift
//  NarratoAI
//
//  Created by Kain Nguyen on 31/3/25.
//

import SwiftUI
import NarratoUI

struct LoginView: View {
    // In MVVM the Output will be located in the ViewModel
    
    struct Output {
        var goToMainScreen: () -> Void
        var goToForgotPassword: () -> Void
    }

    var output: Output

    var body: some View {
        
        ButtonView(action: {
            self.output.goToMainScreen()
        }, title: "Login")
        .padding()
        
        ButtonView(action: {
            self.output.goToForgotPassword()
        }, title: "Forgot Password")
        .padding()
    }
}

#Preview {
    LoginView(output: .init(goToMainScreen: {}, goToForgotPassword: {}))
}
