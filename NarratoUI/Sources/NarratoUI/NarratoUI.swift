// The Swift Programming Language
// https://docs.swift.org/swift-book


import SwiftUI
import Foundation

struct Button: View {
    
    var action: () -> Void
    

    var body: some View {
        Button {
            Text("Test Button")
        } 
    }
}
