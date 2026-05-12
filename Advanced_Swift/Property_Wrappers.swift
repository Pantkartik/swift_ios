import Foundation

/*
 Property Wrappers (@propertyWrapper)
 
 Property wrappers allow you to extract common logic for property access into a reusable wrapper.
 They were introduced in Swift 5.1 and are widely used in SwiftUI (e.g., @State, @Binding).
*/

// --- 1. Basic Property Wrapper: Clamped ---
// Ensures a value stays within a specified range.

@propertyWrapper
struct Clamped<Value: Comparable> {
    var value: Value
    let range: ClosedRange<Value>
    
    var wrappedValue: Value {
        get { value }
        set { value = min(max(newValue, range.lowerBound), range.upperBound) }
    }
    
    init(wrappedValue: Value, _ range: ClosedRange<Value>) {
        self.range = range
        self.value = min(max(wrappedValue, range.lowerBound), range.upperBound)
    }
}

// Usage
struct Player {
    @Clamped(0...100) var health: Int = 100
}

var player = Player()
player.health = 150 // Will be clamped to 100
print("Player Health: \(player.health)") // 100

player.health = -50 // Will be clamped to 0
print("Player Health: \(player.health)") // 0


// --- 2. Property Wrapper with Projected Value ($ syntax) ---
// Allows you to expose additional information or functionality.

@propertyWrapper
struct Logged<Value> {
    private var value: Value
    
    var wrappedValue: Value {
        get { value }
        set {
            print("LOG: Value changed to \(newValue)")
            value = newValue
        }
    }
    
    // Projected value accessible via $ property name
    var projectedValue: String {
        return "This property is being logged."
    }
    
    init(wrappedValue: Value) {
        self.value = wrappedValue
    }
}

struct Settings {
    @Logged var username: String = "Guest"
}

print("--- Property Wrapper with Projected Value ---")
var settings = Settings()
settings.username = "Alice" // Prints "LOG: Value changed to Alice"
print("Projected Value: \(settings.$username)")


// --- Summary ---
/*
 - Use property wrappers to remove boilerplate code.
 - 'wrappedValue' is mandatory.
 - 'projectedValue' is optional and accessed with '$'.
 - They make your data models cleaner and more expressive.
*/
