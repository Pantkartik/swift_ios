import Foundation

/*
 Key-Paths are a way to refer to properties of a type without immediately accessing them.
 Dynamic Member Lookup allows you to access properties that aren't explicitly defined at compile time.
*/

struct Car {
    var model: String
    var year: Int
}

// 1. Key-Path Expressions
let modelKeyPath = \Car.model
let yearKeyPath = \Car.year

let myCar = Car(model: "Tesla Model 3", year: 2023)

print("--- Key-Paths ---")
print("Model using Key-Path: \(myCar[keyPath: modelKeyPath])")

// 2. Dynamic Member Lookup
@dynamicMemberLookup
struct Settings {
    private var storage: [String: String] = [:]
    
    subscript(dynamicMember member: String) -> String {
        get { storage[member] ?? "Not Set" }
        set { storage[member] = newValue }
    }
}

print("\n--- Dynamic Member Lookup ---")
var appSettings = Settings()
appSettings.theme = "Dark Mode" // theme is not a property of Settings!
appSettings.fontSize = "14px"

print("Theme: \(appSettings.theme)")
print("Font Size: \(appSettings.fontSize)")
print("Unknown Setting: \(appSettings.language)")
