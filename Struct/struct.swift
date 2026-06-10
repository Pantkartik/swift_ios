import Foundation

// MARK: - Swift Structs: Understanding Value Types

// A struct is a value type in Swift. When you assign a struct to a new variable or constant,
// or when you pass it to a function, a complete copy of the structure is created.

struct Person {
    var name: String
}

var p1 = Person(name: "KARTIK")
var p2 = p1 // p2 is a unique copy of p1. They do not share memory.

p2.name = "Pant"

// This demonstrates that modifying p2 does not affect p1 because they are value types.
print("p1 name (unchanged):", p1.name) // Prints "KARTIK"
print("p2 name (modified):", p2.name)  // Prints "Pant"

// MARK: - Completing struct Car example
struct Car {
    let make: String
    let model: String
    var mileage: Int
    
    // Structs in Swift automatically receive a memberwise initializer if they do not define custom ones.
    
    // Mutating function: Needed when modifying properties of a struct within its own methods.
    mutating func drive(miles: Int) {
        mileage += miles
    }
}

var myCar = Car(make: "Tesla", model: "Model 3", mileage: 5000)
myCar.drive(miles: 150)
print("My \(myCar.make) mileage is now: \(myCar.mileage)")

// MARK: - Value vs Reference Types
// Structs are value types (stored on the stack, copied on assignment).
// Classes are reference types (stored on the heap, references are shared on assignment).
class ClassPerson {
    var name: String
    init(name: String) {
        self.name = name
    }
}

let cp1 = ClassPerson(name: "KARTIK")
let cp2 = cp1 // cp2 references the same instance as cp1.
cp2.name = "Pant"
print("cp1 name (mutated):", cp1.name) // Prints "Pant" because classes share instances.