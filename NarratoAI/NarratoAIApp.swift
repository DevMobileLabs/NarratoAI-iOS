//
//  NarratoAIApp.swift
//  NarratoAI
//
//  Created by Kain Nguyen on 28/3/25.
//

import SwiftUI
import SwiftData

@main
struct NarratoAIApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}



// Coordinator class
class Coordinator: ObservableObject {
    // Manage the navigation stack here
    @Published var navigationPath = NavigationPath()
    
    func pushPage(_ page: Page) {
        
        if page == .root {
            // Home is the root, so we clear the path to navigation back
            navigationPath.removeLast(navigationPath.count)
        } else {
            navigationPath.append(page)
        }
    }
    
    func clearNavigationStack() {
        navigationPath.removeLast(navigationPath.count)
    }
    
    enum Page: Hashable {
        case root, other, purple, pink, orange, genderEntry, green
    }
}

// MARK: - NavigationButtonStyle
struct NavigationButtonStyle: ButtonStyle {
    var backgroundColor: Color = .blue
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(backgroundColor)
            .foregroundColor(.white)
            .cornerRadius(10)
    }
}

extension Coordinator.Page: CustomStringConvertible {
    var description: String {
        switch self {
        case .root: return "Root"
        case .other: return "Other"
        case .purple: return "Purple"
        case .pink: return "Pink"
        case .orange: return "Orange"
        case .genderEntry: return "Gender Entry"
        case .green: return "Green"
        }
    }
}

// MARK: - Color Extension
// Extension to define a custom color
extension Color {
    static let lowGray = Color.gray.opacity(0.4)
}
