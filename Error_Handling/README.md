# Error Handling in Swift ⚠️

Error handling is a critical part of writing robust and reliable Swift applications. This section covers Swift's core error-handling paradigms, from the basic `throws` syntax to advanced concepts like `Result`, `defer`, `rethrows`, and Swift 6 **Typed Throws**.

## 📁 Files in this Section

- [ErrorHandling_Basics.swift](file:///Users/pantkartik/Ios_dev/swift_ios/Error_Handling/ErrorHandling_Basics.swift): Foundation of Swift error handling (custom `Error` types, `throws`, `do-catch`, and `try?`/`try!`).
- [ErrorHandling_Advanced.swift](file:///Users/pantkartik/Ios_dev/swift_ios/Error_Handling/ErrorHandling_Advanced.swift): Advanced concepts (`Result`, `defer`, `rethrows`, and **Typed Throws**).

---

## 📌 Core Paradigms

### 1. Errors as Types
Errors in Swift are represented by values of types conforming to the empty `Error` protocol. Enums are ideally suited for modeling grouped error cases:

```swift
enum DatabaseError: Error {
    case connectionFailed
    case entryNotFound(id: String)
    case writePermissionDenied
}
```

### 2. Throwing Functions & Propagation
To indicate that a function, method, or initializer can throw an error, write the `throws` keyword in its declaration after its parameters:

```swift
func findUser(id: String) throws -> User {
    guard db.isConnected else {
        throw DatabaseError.connectionFailed
    }
    guard let user = db.fetch(id) else {
        throw DatabaseError.entryNotFound(id: id)
    }
    return user
}
```

### 3. Handling Errors with Do-Catch
You use a `do-catch` block to handle errors by running a block of code and pattern-matching any errors that might occur:

```swift
do {
    let user = try findUser(id: "123")
    print("User found: \(user.name)")
} catch DatabaseError.connectionFailed {
    print("Database connection issue. Please retry.")
} catch DatabaseError.entryNotFound(let id) {
    print("User with ID \(id) does not exist.")
} catch {
    // Fallback block captures untyped errors as local constant 'error'
    print("An unexpected error occurred: \(error.localizedDescription)")
}
```

### 4. Converting Errors to Optionals (`try?` & `try!`)
- **`try?`**: Converts the result of a throwing function to an optional. If an error is thrown, the expression evaluates to `nil`.
- **`try!`**: Disables error propagation and asserts that the call will not throw. If the call does throw, the application crashes.

| Syntax | Description | Success Type | Error Behavior | Best For |
|---|---|---|---|---|
| `try` | Standard propagation | `T` | Propagates error up | Standard workflow inside do-catch or throwing functions |
| `try?` | Optional conversion | `T?` | Returns `nil` | Simple assignments where error details don't matter |
| `try!` | Forced unwrapping | `T` | Crashes runtime | Prototyping, unit tests, or loading local resources that *must* exist |

---

## 🚀 Advanced Concepts

### 5. The Result Type
For asynchronous operations or when errors need to be stored as values, Swift provides the `Result<Success, Failure>` enum, where `Failure` conforms to `Error`.

```swift
func fetchUserData(completion: @escaping (Result<User, DatabaseError>) -> Void) {
    // Asynchronous call...
}
```

### 6. The Defer Statement
The `defer` statement is used to execute a block of code just before leaving the current scope. It is useful for cleaning up resources, closing files, or releasing locks, regardless of whether the scope is exited normally or via a thrown error:

```swift
func processFile() throws {
    let file = openFile("data.txt")
    defer {
        closeFile(file) // Always runs on exit
        print("File closed successfully.")
    }
    
    try readData(file)
}
```

### 7. Rethrows
A function marked with `rethrows` indicates that it only throws an error if one of its function parameters throws:

```swift
func performAction(_ action: () throws -> Void) rethrows {
    try action()
}
```

### 8. Swift 6 Typed Throws
Prior to Swift 6, all errors thrown by functions were untyped (represented as `any Error`). Swift 6 introduces **Typed Throws**, allowing you to specify the exact type of error a function can throw. This provides compile-time type safety:

```swift
// This function can ONLY throw errors of type NetworkError
func fetchData() throws(NetworkError) -> Data {
    guard hasConnection else {
        throw NetworkError.noConnection
    }
    return data
}

// In the catch block, the error is statically typed as NetworkError
do {
    let data = try fetchData()
} catch {
    // 'error' is automatically inferred as NetworkError (not 'any Error')
    switch error {
    case .noConnection:
        print("No connection")
    case .timeout:
        print("Timeout")
    }
}
```

---

## 🛠️ Best Practices

1. **Be Specific**: Create custom error enums with clear names and associated values to provide meaningful context.
2. **Clean Up with Defer**: Always pair resource allocations (like opening files or acquiring locks) with a `defer` block immediately.
3. **Prefer Async/Await over Result**: In modern Swift (5.5+), use async/await for asynchronous error handling instead of nested `Result` callbacks, as it keeps code clean and readable.
4. **Use Typed Throws Judiciously**: Use Swift 6 typed throws when you want to enforce strict error handling contracts within internal frameworks, SDKs, or performance-critical loops. Prefer untyped throws for general application logic to avoid strict coupling.
