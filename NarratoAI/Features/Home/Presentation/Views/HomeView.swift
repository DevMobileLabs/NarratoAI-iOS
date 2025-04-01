//
//  HomeView.swift
//  NarratoAI
//
//  Created by Kain Nguyen on 31/3/25.
//

import Combine
import SwiftUI

struct HomeView: View {
    let didClickMenuItem = PassthroughSubject<String, Never>()
    @State var menuItems = ["Settings", "Profile"]

    var body: some View {
        NavigationView {
            List {
                ForEach(menuItems, id: \.self) { item in
                    Button(action: {
                        didClickMenuItem.send(item)
                    }) {
                        Text(item)
                    }
                }
            }
            .navigationBarTitle("MVVMC DEMO")
        }
    }
}

#Preview {
    HomeView()
}
