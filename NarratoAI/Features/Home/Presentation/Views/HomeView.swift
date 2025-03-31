//
//  HomeView.swift
//  NarratoAI
//
//  Created by Kain Nguyen on 31/3/25.
//

import SwiftUI

struct HomeView: View {

    var output: Output

    struct Output {
        var logout: () -> Void
    }

    var body: some View {
        VStack {
            Text("Home Screen")
                .font(.largeTitle)

            Button("Logout") {
                output.logout()
            }
            .buttonStyle(.borderedProminent)
        }
    }
}

#Preview {
    HomeView(
        output: .init(logout: {

        }))
}
