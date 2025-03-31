//
//  HomeCoordinator.swift
//  NarratoAI
//
//  Created by Kain Nguyen on 28/3/25.
//

import SwiftUI

class HomeCoordinator: Hashable {
    @Binding var navigationPath: NavigationPath

    private var id: UUID
    private var output: Output?

    init(
        navigationPath: Binding<NavigationPath>,
        output: Output? = nil
    ) {
        id = UUID()
        self.output = output
        self._navigationPath = navigationPath
    }

    struct Output {
        var logout: () -> Void
    }

    @ViewBuilder
    func view() -> some View {
        homeView()
    }

    private func homeView() -> some View {
        let homeView = HomeView(
            output: .init(logout: {
                self.output?.logout()
            })
        )
        return homeView
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: HomeCoordinator, rhs: HomeCoordinator) -> Bool {
        lhs.id == rhs.id
    }
}
