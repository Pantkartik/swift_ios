import Foundation

// Property Wrappers allow you to add custom logic to property access.

@propertyWrapper
struct Trimmed {
    private var value: String = ""
    
    var wrappedValue: String {
        get { value }
        set { value = newValue.trimmingCharacters(in: .whitespacesAndNewlines) }
    }
    
    init(wrappedValue: String) {
        self.wrappedValue = wrappedValue
    }
}

@propertyWrapper
struct Clamped<T: Comparable> {
    private var value: T
    private let range: ClosedRange<T>
    
    var wrappedValue: T {
        get { value }
        set { value = min(max(newValue, range.lowerBound), range.upperBound) }
    }
    
    init(wrappedValue: T, _ range: ClosedRange<T>) {
        self.value = wrappedValue
        self.range = range
    }
}

struct UserProfile {
    @Trimmed var username: String
    @Clamped(0...100) var score: Int
}

print("--- Property Wrappers ---")

var profile = UserProfile(username: "  SwiftUser123  ", score: 150)
print("Username: '\(profile.username)'") // Should be trimmed
print("Score: \(profile.score)") // Should be clamped to 100

profile.score = -50
print("Score after update: \(profile.score)") // Should be clamped to 0
