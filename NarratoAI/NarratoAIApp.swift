//
//  NarratoAIApp.swift
//  NarratoAI
//
//  Created by Kain Nguyen on 28/3/25.
//

import SwiftData
import SwiftUI

@main
struct NarratoAIApp: App {
    @StateObject private var appCoordinator = AppFlowCoordinator(
        path: NavigationPath())

    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $appCoordinator.path) {
                appCoordinator.view()
                    .navigationDestination(for: AuthCoordinator.self) {
                        coordinator in
                        coordinator.view()
                    }
                    .navigationDestination(for: HomeCoordinator.self) {
                        coordinator in
                        coordinator.view()
                    }
            }
        }
        .environmentObject(appCoordinator)
    }
}
