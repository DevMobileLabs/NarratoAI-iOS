//
//  LoginViewModel.swift
//  NarratoAI
//
//  Created by Kain Nguyen on 31/3/25.
//
import SwiftUI

class LoginViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var password: String = ""

    // Add this initializer to accept the closures
    init(
        onLoginSuccess: (() -> Void)? = nil,
        onForgotPassword: (() -> Void)? = nil
    ) {
        self.onLoginSuccess = onLoginSuccess
        self.onForgotPassword = onForgotPassword
    }

    var onLoginSuccess: (() -> Void)?
    var onForgotPassword: (() -> Void)?

    func login() {
        // Thực hiện xác thực đăng nhập
        let isAuthenticated = true  // Giả sử đã xác thực thành công
        if isAuthenticated {
            onLoginSuccess?()
        }
    }

    func forgotPassword() {
        onForgotPassword?()
    }
}
