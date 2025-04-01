//
//  MainProfileView.swift
//  NarratoAI
//
//  Created by Kain Nguyen on 1/4/25.
//

import SwiftUI
import Combine

struct MainProfileView: View {
    let didClickPersonal = PassthroughSubject<Bool, Never>()
    let didClickEducation = PassthroughSubject<Bool, Never>()
    
    var body: some View {
        List {
            Button(action: {
                didClickPersonal.send(true)
            }) {
                Text("Personal Details")
            }
            Button(action: {
                didClickEducation.send(true)
            }) {
                Text("Educational Details")
            }
        }
        .navigationBarTitle("Profile")
    }
}


#Preview {
    MainProfileView()
}
