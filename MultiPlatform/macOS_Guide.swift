import SwiftUI

// MARK: - macOS App Entry Point
@main
struct MacOSApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .commands {
            // Adding standard macOS menus
            CommandGroup(replacing: .newItem, addition: {
                Button("New Custom Item") {
                    print("New item created")
                }
                .keyboardShortcut("n", modifiers: [.command, .shift])
            })
        }
    }
}

// MARK: - Mac-Specific UI Adjustments
struct ContentView: View {
    var body: some View {
        Text("Hello, macOS!")
            .padding()
            // Hover effect specific to pointer interactions
            .onHover { isHovering in
                print(isHovering ? "Mouse entered" : "Mouse exited")
            }
    }
}
