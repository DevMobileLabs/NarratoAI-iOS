//
//  AuthCoordinator.swift
//  NarratoAI
//
//  Created by Kain Nguyen on 28/3/25.
//

import Foundation
import SwiftUI

enum AuthenticationPage {
    case login, forgotPassword
}

class AuthCoordinator: Hashable {
    @Binding var navigationPath: NavigationPath

    private var id: UUID
    private var output: Output?
    private var page: AuthenticationPage

    init(
        page: AuthenticationPage,
        navigationPath: Binding<NavigationPath>,
        output: Output? = nil
    ) {
        id = UUID()
        self.page = page
        self.output = output
        self._navigationPath = navigationPath
    }

    struct Output {
        var goToMainScreen: () -> Void
    }

    @ViewBuilder
    func view() -> some View {
        switch self.page {
        case .login:
            loginView()
        case .forgotPassword:
            forgotPasswordView()
        }
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (
        lhs: AuthCoordinator,
        rhs: AuthCoordinator
    ) -> Bool {
        lhs.id == rhs.id
    }

    private func loginView() -> some View {
        let loginView = LoginView(
            output:
                .init(
                    goToMainScreen: {
                        self.output?.goToMainScreen()
                    },
                    goToForgotPassword: {
                        self.push(
                            AuthCoordinator(
                                page: .forgotPassword,
                                navigationPath: self.$navigationPath
                            )
                        )
                    }
                )
        )
        return loginView
    }

    private func forgotPasswordView() -> some View {
        let forgotPasswordView = ForgotPasswordView(
            output:
                .init(
                    goToForgotPasswordWebsite: {
                        self.goToForgotPasswordWebsite()
                    }
                )
        )
        return forgotPasswordView
    }

    private func goToForgotPasswordWebsite() {
        if let url = URL(string: "https://www.google.com") {
            UIApplication.shared.open(url)
        }
    }

    func push<V>(_ value: V) where V: Hashable {
        navigationPath.append(value)
    }
}
