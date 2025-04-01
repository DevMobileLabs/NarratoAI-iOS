//
//  HomeCoordinator.swift
//  NarratoAI
//
//  Created by Kain Nguyen on 28/3/25.
//

import Combine
import SwiftUI

// Enum to identify Settings flow screen Types
enum HomePage: String, Identifiable {
    case main

    var id: String {
        self.rawValue
    }
}

class HomeFlowCoordinator: ObservableObject, Hashable {
    @Published var page: HomePage

    private var id: UUID
    private var cancellables = Set<AnyCancellable>()

    let pushCoordinator = PassthroughSubject<AnyHashable, Never>()

    init(page: HomePage) {
        id = UUID()
        self.page = page
    }

    @ViewBuilder
    func build() -> some View {
        switch self.page {
        case .main:
            mainHomeView()
        }
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: HomeFlowCoordinator, rhs: HomeFlowCoordinator) -> Bool
    {
        lhs.id == rhs.id
    }

    // MARK: View Creation Methods
    private func mainHomeView() -> some View {
        let homeView = HomeView()
        bind(view: homeView)
        return homeView
    }

    // MARK: View Bindings
    private func bind(view: HomeView) {
        view.didClickMenuItem
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] item in
                print("HomeFlowCoordinator received click: \(item)")
                switch item {
                case "Settings":
                    print("Should push Settings flow")
                    self?.pushSettingsFlow()
                case "Profile":
                    print("Should push Profile flow")
                    self?.pushProfileFlow()
                case "Privacy":
                    self?.showPrivacySettings()
                default:
                    break
                }
            })
            .store(in: &cancellables)
    }
}

// MARK: Navigation Related Extensions
extension HomeFlowCoordinator {
    private func pushSettingsFlow() {
        pushCoordinator.send(SettingsFlowCoordinator(page: .main))
    }

    private func pushProfileFlow() {
        pushCoordinator.send(ProfileFlowCoordinator(page: .main))
    }

    private func showPrivacySettings() {
        pushCoordinator.send(SettingsFlowCoordinator(page: .privacy))
    }
}
