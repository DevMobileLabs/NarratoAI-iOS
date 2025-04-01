//
//  AppCoordinator.swift
//  NarratoAI
//
//  Created by Kain Nguyen on 28/3/25.
//

import Combine
import SwiftUI

class AppFlowCoordinator: ObservableObject {
    @Published var path: NavigationPath
    private var cancellables = Set<AnyCancellable>()

    init(path: NavigationPath) {
        self.path = path
    }

    @ViewBuilder
    func build() -> some View {
        buildHomeFlow()
    }

    private func push<T: Hashable>(_ coordinator: T) {
        path.append(coordinator)
    }

    // MARK: Flow Control Methods
    private func buildHomeFlow() -> some View {
        let homeCoordinator = HomeFlowCoordinator(page: .main)
        bind(homeCoordinator: homeCoordinator)
        return homeCoordinator.build()
    }

    private func settingsFlow() {
        let settingsFlowCoordinator = SettingsFlowCoordinator(page: .main)
        self.bind(settingsCoordinator: settingsFlowCoordinator)
        self.push(settingsFlowCoordinator)
    }

    private func profileFlow() {
        let profileFlowCoordinator = ProfileFlowCoordinator(page: .main)
        self.bind(profileCoordinator: profileFlowCoordinator)
        self.push(profileFlowCoordinator)
    }

    // MARK: Flow Coordinator Bindings

    // Update the bind(homeCoordinator:) method
    private func bind(homeCoordinator: HomeFlowCoordinator) {
        homeCoordinator.pushCoordinator
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] coordinator in
                    self?.push(coordinator)
            })
            .store(in: &cancellables)
    }
    
    private func bind(settingsCoordinator: SettingsFlowCoordinator) {
        settingsCoordinator.pushCoordinator
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] coordinator in
                self?.push(coordinator)
            })
            .store(in: &cancellables)
    }

    private func bind(profileCoordinator: ProfileFlowCoordinator) {
        profileCoordinator.pushCoordinator
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] coordinator in
                self?.push(coordinator)
            })
            .store(in: &cancellables)
    }
}
