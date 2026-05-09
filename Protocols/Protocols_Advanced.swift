import Foundation

// 1. Associated Types in Protocols (Generics for Protocols)
protocol Container {
    associatedtype Item
    var count: Int { get }
    mutating func append(_ item: Item)
    subscript(i: Int) -> Item { get }
}

struct IntStack: Container {
    // Conformance inferred: typealias Item = Int
    var items: [Int] = []
    
    var count: Int { items.count }
    
    mutating func append(_ item: Int) {
        items.append(item)
    }
    
    subscript(i: Int) -> Int {
        items[i]
    }
}

// 2. Protocol Extensions (Default Implementations)
// This is the core of Protocol-Oriented Programming (POP)
protocol Validatable {
    var isValid: Bool { get }
    func validate() -> Bool
}

extension Validatable {
    // Default implementation
    func validate() -> Bool {
        print("Running default validation...")
        return isValid
    }
}

struct Email: Validatable {
    var text: String
    var isValid: Bool {
        text.contains("@") && text.contains(".")
    }
    
    // Uses default validate() or can override
}

struct Password: Validatable {
    var text: String
    var isValid: Bool {
        text.count >= 8
    }
    
    // Custom override
    func validate() -> Bool {
        print("Running secure password validation...")
        return isValid
    }
}

// 3. Conditional Conformance
extension Array: Validatable where Element: Validatable {
    var isValid: Bool {
        allSatisfy { $0.isValid }
    }
}

// Usage
print("--- Advanced Protocols ---")
var stack = IntStack()
stack.append(10)
stack.append(20)
print("Stack count: \(stack.count)")

let email = Email(text: "test@example.com")
print("Email valid: \(email.validate())")

let pass = Password(text: "123")
print("Password valid: \(pass.validate())")

let validations: [any Validatable] = [email, pass]
print("All valid: \(validations.allSatisfy { $0.isValid })")
