//
//  AppCoordinator.swift
//  NarratoAI
//
//  Created by Kain Nguyen on 28/3/25.
//

import Foundation
import SwiftUI

enum AppPage {
    case auth
    case home
}

class AppFlowCoordinator: ObservableObject {
    @Published var path: NavigationPath
    @Published var appPage: AppPage = .auth

    init(path: NavigationPath) {
        self.path = path
    }

    @ViewBuilder
    func view() -> some View {
        switch appPage {
        case .auth:
            authCoordinator().view()
        case .home:
            homeCoordinator().view()
        }
    }

    func authCoordinator() -> AuthCoordinator {
        return AuthCoordinator(
            page: .login,
            navigationPath: Binding(
                get: { self.path },
                set: { self.path = $0 }
            ),
            output: .init(goToMainScreen: {
                self.appPage = .home
            })
        )
    }



    func homeCoordinator() -> HomeCoordinator {
        return HomeCoordinator(
            navigationPath: Binding(
                get: { self.path },
                set: { self.path = $0 }
            ),
            output: .init(logout: {
                self.appPage = .auth
            })
        )
    }
}
