//
//  LoginView.swift
//  NarratoAI
//
//  Created by Kain Nguyen on 31/3/25.
//

import NarratoUI
import SwiftUI

struct LoginView: View {
    @StateObject var viewModel: LoginViewModel

    var body: some View {
        VStack {
            ButtonView(
                action: {
                    viewModel.login()
                }, title: "Login"
            )
            .padding()

            ButtonView(
                action: {
                    viewModel.forgotPassword()
                }, title: "Forgot Password"
            )
            .padding()
        }
        .onAppear {
            viewModel.onLoginSuccess = {
                // Điều hướng đến màn hình chính
            }
            viewModel.onForgotPassword = {
                // Điều hướng đến màn hình quên mật khẩu
            }
        }
    }
}

#Preview {
    LoginView(viewModel: LoginViewModel())
}
