import SwiftUI

/// A demonstration of modern localization techniques in Swift and SwiftUI.
struct LocalizationExample: View {
    // 1. Basic localization using String(localized:)
    let simpleGreeting = String(localized: "Hello, World!")
    
    // 2. Localization with a comment for translators
    let welcomeMessage = String(
        localized: "Welcome to our app!",
        comment: "Shown on the home screen after login"
    )
    
    @State private var itemCount = 0
    
    var body: some View {
        VStack(spacing: 20) {
            // 3. SwiftUI Text views localize automatically
            Text("Localization Demo")
                .font(.headline)
            
            Text(simpleGreeting)
            Text(welcomeMessage)
            
            Divider()
            
            // 4. Pluralization & Interpolation
            // When using String Catalogs, you right-click this key in the .xcstrings file
            // and select "Vary by Plural" to handle 0, 1, or multiple items.
            Text("You have \(itemCount) items.")
            
            HStack {
                Button("Decrease") { itemCount = max(0, itemCount - 1) }
                Button("Increase") { itemCount += 1 }
            }
            .buttonStyle(.bordered)
            
            // 5. Explicit key with default value
            Text(String(localized: "REMAINING_STORAGE_KEY", defaultValue: "Storage is almost full!"))
                .foregroundColor(.red)
                .font(.caption)
        }
        .padding()
    }
}

// MARK: - Legacy Approach (Reference)
/*
// The old way (NSLocalizedString)
let legacy = NSLocalizedString("hello_key", comment: "")

// The new way
let modern = String(localized: "hello_key")
*/
