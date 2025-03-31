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
    @EnvironmentObject var appCoordinator: AppFlowCoordinator

    var body: some View {
        Group {
            AuthCoordinator(
                page: .login,
                navigationPath: $appCoordinator.path,
                output: .init(
                    goToMainScreen: {
                        print("Go to main screen (MainTabView)")
                    }
                )
            ).view()
        }
    }
}

#Preview {
    MainView()
}
