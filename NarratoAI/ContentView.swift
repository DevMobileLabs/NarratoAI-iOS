//
//  ContentView.swift
//  NarratoAI
//
//  Created by Kain Nguyen on 28/3/25.
//

import SwiftUI
import SwiftData
import NarratoUI

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]

    var body: some View {
        
        ButtonView {
            print("Press Button")
        }
        
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
