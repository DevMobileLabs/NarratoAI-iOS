//
//  ContentView.swift
//  NarratoAI
//
//  Created by Kain Nguyen on 28/3/25.
//

import NarratoUI
import SwiftData
import SwiftUI

struct MainView: View {
    @StateObject private var appCoordinator = AppFlowCoordinator(path: NavigationPath())

    var body: some View {
        NavigationStack(path: $appCoordinator.path) {
            appCoordinator.build()
                .navigationDestination(for: HomeFlowCoordinator.self) {
                    coordinator in
                    coordinator.build()
                }
                .navigationDestination(for: SettingsFlowCoordinator.self) {
                    coordinator in
                    coordinator.build()
                }
                .navigationDestination(for: ProfileFlowCoordinator.self) {
                    coordinator in
                    coordinator.build()
                }
        }
        .environmentObject(appCoordinator)
    }
}

#Preview {
    MainView()
        .environmentObject(AppFlowCoordinator(path: NavigationPath()))
}
