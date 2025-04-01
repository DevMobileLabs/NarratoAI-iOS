//
//  MainSettingsView.swift
//  NarratoAI
//
//  Created by Kain Nguyen on 1/4/25.
//
import SwiftUI
import Combine

struct MainSettingsView: View {
    let didClickPrivacy = PassthroughSubject<Bool, Never>()
    let didClickCustom = PassthroughSubject<Bool, Never>()
    
    var body: some View {
        List {
            Button(action: {
                didClickPrivacy.send(true)
            }) {
                Text("Privacy Settings")
            }
        }
        .navigationBarTitle("Settings")
    }
}

#Preview {
    MainSettingsView()
}
