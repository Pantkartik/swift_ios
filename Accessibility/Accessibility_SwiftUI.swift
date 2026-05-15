import SwiftUI

/*
 Accessibility in SwiftUI
 
 SwiftUI makes it incredibly easy to add accessibility support to your views.
 Most standard components have built-in support, but you should always customize them for the best experience.
*/

struct AccessibilityExampleView: View {
    @State private var quantity = 1
    
    var body: some View {
        VStack(spacing: 30) {
            // 1. Basic Label and Hint
            Image(systemName: "heart.fill")
                .foregroundColor(.red)
                .font(.system(size: 50))
                .accessibilityLabel("Favorite")
                .accessibilityHint("Adds this item to your favorites list")
                .accessibilityAddTraits(.isButton)
            
            // 2. Dynamic Type Support
            // Use relativeTo to ensure the custom font scales correctly with the system text size.
            Text("Dynamic Type Example")
                .font(.custom("Georgia", size: 24, relativeTo: .title))
            
            // 3. Accessibility Values
            HStack {
                Button(action: { quantity -= 1 }) {
                    Image(systemName: "minus.circle")
                }
                .accessibilityLabel("Decrease quantity")
                
                Text("\(quantity)")
                    .font(.title)
                    .accessibilityLabel("Current quantity")
                    .accessibilityValue("\(quantity) items")
                
                Button(action: { quantity += 1 }) {
                    Image(systemName: "plus.circle")
                }
                .accessibilityLabel("Increase quantity")
            }
            .accessibilityElement(children: .combine) // Combines elements into one focusable area
            .accessibilityLabel("Adjust quantity")
            .accessibilityValue("\(quantity) items")
            
            // 4. Hiding Decorative Elements
            Image("decorative-pattern")
                .accessibilityHidden(true)
        }
        .padding()
    }
}

/*
 Best Practices:
 - Avoid using "button" or "image" in the label; the system adds traits automatically.
 - Keep labels short and descriptive.
 - Use hints for non-obvious actions.
 - Test with the Accessibility Inspector (Xcode -> Open Developer Tool -> Accessibility Inspector).
*/

#Preview {
    AccessibilityExampleView()
}

print("--- SwiftUI Accessibility ---")
print("Demonstrated accessibilityLabel, accessibilityHint, and accessibilityValue.")
print("Shown how to combine elements for better VoiceOver navigation.")
print("Included Dynamic Type support example.")
