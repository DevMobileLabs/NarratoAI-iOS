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
            CoordinatorContentView()
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

// ViewModel Protocols
protocol RootViewModelProtocol {
    func navigateToPage(_ page: Coordinator.Page)
}

protocol ColorViewModelProtocol {
    func navigateBackToRoot()
}

// RootViewModel
class RootViewModel: RootViewModelProtocol, ObservableObject {
    var coordinator: Coordinator
    
    init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }
    
    func navigateToPage(_ page: Coordinator.Page) {
        coordinator.pushPage(page)
    }
}

// ColorViewModel
class ColorViewModel: ColorViewModelProtocol, ObservableObject {
    var coordinator: Coordinator
    
    init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }
    
    func navigateBackToRoot() {
        coordinator.pushPage(.root)
    }
}



// ContentView with NavigationStack
struct CoordinatorContentView: View {
    @StateObject var coordinator = Coordinator()
    
    var body: some View {
        NavigationStack(path: $coordinator.navigationPath) {
            ZStack {
                Color.red.ignoresSafeArea() // Background color for the entire screen
                
                RootView(viewModel: RootViewModel(coordinator: coordinator))
                    .background(Color.red.ignoresSafeArea())
                    .navigationDestination(for: Coordinator.Page.self) { page in
                        ColorView(page: page, viewModel: ColorViewModel(coordinator: coordinator))
                    }
            }
        } // End of NavigationStack
    } // End of body View
}

// MARK: - RootView
struct RootView: View {
    @ObservedObject var viewModel: RootViewModel
    
    var body: some View {
        VStack(spacing: 10) {
            ForEach([Coordinator.Page.other, .purple, .pink, .orange], id: \.self) { page in
                Button("Go to \(page.description)") {
                    viewModel.navigateToPage(page)
                }
                .buttonStyle(NavigationButtonStyle())
            }
        }
        .navigationTitle("Root View")
        .background(Color.yellow)
        .foregroundColor(.green)
        .safeAreaPadding()
        
    }
}

// MARK: - ColorView
struct ColorView: View {
    let page: Coordinator.Page
    @ObservedObject var viewModel: ColorViewModel
    
    var body: some View {
        ZStack {
            colorForPage(page).ignoresSafeArea()
            switch page {
            case .other:
                OtherView(viewModel: viewModel)
            case .genderEntry:
                GenderEntryView()
            case .green:
                GreenView(viewModel: viewModel)
            default:
                ColorDetailView(color: colorForPage(page), viewModel: viewModel)
            }
        }
    }
    
    private func colorForPage(_ page: Coordinator.Page) -> Color {
        switch page {
        case .other:
            return .gray
        case .purple:
            return .purple
        case .pink:
            return .pink
        case .orange:
            return .orange
        case .green:
            return .green
        default:
            return .clear
        }
    }
}

// MARK: - OtherView
struct OtherView: View {
    @ObservedObject var viewModel: ColorViewModel
    
    var body: some View {
        VStack(spacing: 10) {
            Button("Back to Root View") {
                viewModel.navigateBackToRoot()
            }
            .buttonStyle(NavigationButtonStyle(backgroundColor: .blue))
            
            Button("Go to Gender Entry") {
                viewModel.coordinator.pushPage(.genderEntry)
            }
            .buttonStyle(NavigationButtonStyle(backgroundColor: .brown))
        }
        .navigationTitle("Other View")
        .foregroundColor(.red)
    }
}

// MARK: - ColorDetailView
struct ColorDetailView: View {
    let color: Color
    @ObservedObject var viewModel: ColorViewModel
    
    var body: some View {
        VStack {
            Text("This is the \(color.description) view")
            
            if color == .purple {
                Button("Go to Green View") {
                    viewModel.coordinator.pushPage(.green)
                }
                .buttonStyle(NavigationButtonStyle(backgroundColor: .green))
            }
            
            Button("Back to the Root View") {
                viewModel.navigateBackToRoot()
            }
            .buttonStyle(NavigationButtonStyle())
        }
        .navigationTitle("\(color.description.capitalized) View")
    }
}

// MARK: - GreenView
struct GreenView: View {
    @ObservedObject var viewModel: ColorViewModel
    
    var body: some View {
        VStack {
            Button("Back to Root View") {
                // Clear the navigation stack and push the RootView
                viewModel.coordinator.clearNavigationStack()
                viewModel.coordinator.pushPage(.root)
            }
            .buttonStyle(NavigationButtonStyle())
        }
        .navigationTitle("Green View")
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

// MARK: - Preview
#Preview {
    CoordinatorContentView()
}


// MARK: - UserDataViewModel
// A simple UserDataViewModel class with a function to save gender
class UserDataViewModel: ObservableObject {
    func saveGender(gender: String) {
        // Implementation to save the selected gender
        print("Gender saved: \(gender)")
    }
}

// MARK: - TextComponent
// A simple Text component with customizable style and font size
struct TextComponent: View {
    let text: String
    let foregroundStyle: Color
    let fontSize: CGFloat
    
    var body: some View {
        Text(text)
            .foregroundColor(foregroundStyle)
            .font(.system(size: fontSize))
    }
}

// MARK: - ButtonComponentView
// A simple Button component with customizable properties
struct ButtonComponentView: View {
    let buttonText: String
    let action: () -> Void
    let paddingValue: CGFloat
    let accessibilityLabel: String
    let backgroundColor: Color
    let textColor: Color
    
    var body: some View {
        Button(action: action) {
            Text(buttonText)
                .frame(maxWidth: .infinity)
                .padding()
                .background(backgroundColor)
                .foregroundColor(textColor)
                .cornerRadius(10)
                .padding(.horizontal, paddingValue)
        }
        .accessibilityLabel(accessibilityLabel)
    }
}

// MARK: - GenderEntryView
struct GenderEntryView: View {

    @Environment(\.dismiss) var dismiss
    
    @StateObject private var viewModel = UserDataViewModel()
    
    @State private var selectedIndex = 0
    @State private var isPresented = false
    
    private let selectNames = ["Male", "Female", "Other"]
    
    var body: some View {
        VStack{
            TextComponent(text: "Please tell me your gender", foregroundStyle: .black, fontSize: 20)
                .frame(width: 260)
                .padding(.top, 50)
                .multilineTextAlignment(.center)
            
            List{
                ForEach(0..<selectNames.count, id: \.self, content: { index in
                    HStack{
                        TextComponent(text: selectNames[index], foregroundStyle: .black, fontSize: 20)
                        Spacer()
                        if selectedIndex == index {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.black)
                        }
                    }
                    .padding(.vertical,20)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        selectedIndex = index
                    }
                })
            } // End of List
            .scrollContentBackground(.hidden)
            .padding(.top,20)
            
            Spacer()
            
            ButtonComponentView(buttonText: "Next", action: {
                viewModel.saveGender(gender: selectNames[selectedIndex])
                isPresented = true
            }, paddingValue: 30, accessibilityLabel: "Next", backgroundColor: .black, textColor: .white)
            
            ButtonComponentView(buttonText: "Skip", action: { isPresented = true }, paddingValue: 80, accessibilityLabel: "Skip", backgroundColor: .lowGray, textColor: .black)
            
        } // End of VStack
        .navigationTitle("Gender Entry View")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            backButtonToolbarItem(dismiss: { dismiss() }) // go back to the Root view
        }
        .navigationDestination(isPresented: $isPresented) {
            MbtiEntryView()
        }
    }
    
    // A custom toolbar item for a back button
    func backButtonToolbarItem(dismiss: @escaping () -> Void) -> some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            Button(action: dismiss) {
                Image(systemName: "arrow.left")
            }
        }
    }
    
}

// MARK: - Color Extension
// Extension to define a custom color
extension Color {
    static let lowGray = Color.gray.opacity(0.4)
}

// MARK: - MbtiEntryView
// A placeholder view for the MbtiEntryView
struct MbtiEntryView: View {

    var body: some View {
        Text("MBTI Entry View")
    }
}

