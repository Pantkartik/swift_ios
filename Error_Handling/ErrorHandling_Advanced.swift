import Foundation

/// Swift Advanced Error Handling
///
/// This file covers:
/// 1. The `Result` type (`Result<Success, Failure>`)
/// 2. The `defer` statement and scope execution order
/// 3. The `rethrows` keyword for higher-order functions
/// 4. Swift 6 Typed Throws (`throws(ErrorType)`)

// MARK: - 1. The Result Type
print("--- 1. Result Type ---")

enum FileError: Error {
    case fileNotFound
    case permissionDenied
}

// A function returning a Result type (useful in async callbacks or storing states)
func readFile(at path: String) -> Result<String, FileError> {
    if path.isEmpty {
        return .failure(.fileNotFound)
    } else if path == "/protected" {
        return .failure(.permissionDenied)
    }
    return .success("Contents of file at \(path)")
}

// Usage with switch pattern matching
let result = readFile(at: "/protected")
switch result {
case .success(let content):
    print("Success: \(content)")
case .failure(let error):
    switch error {
    case .fileNotFound:
        print("Error: File not found.")
    case .permissionDenied:
        print("Error: Access denied.")
    }
}

// Converting Result back to a throwing call using result.get()
do {
    let content = try readFile(at: "/documents/resume.txt").get()
    print("Fetched via get(): \(content)")
} catch {
    print("Caught error from get(): \(error)")
}


// MARK: - 2. Defer Statement
print("\n--- 2. Defer Statement ---")

func simulateFileAccess(shouldFail: Bool) throws {
    print("1. Opening database connection...")
    
    // defers are executed in LIFO (Last In, First Out) order when exiting scope
    defer {
        print("5. Closing database connection (First defer declared, executed last).")
    }
    
    defer {
        print("4. Cleaning up temporary cache (Second defer declared, executed first).")
    }
    
    print("2. Writing to database...")
    if shouldFail {
        print("3. Threw error! Exiting scope early...")
        throw FileError.permissionDenied
    }
    
    print("3. Finished database operations.")
}

do {
    try simulateFileAccess(shouldFail: true)
} catch {
    print("Caught database error.")
}


// MARK: - 3. Rethrows
print("\n--- 3. Rethrows ---")

// This function only throws if the passed closure throws.
func executeTask(action: () throws -> Void) rethrows {
    print("Starting wrapper task...")
    try action()
    print("Completed wrapper task.")
}

// Scenario A: Calling with a non-throwing closure. No 'try' required!
executeTask {
    print("Executing simple, non-throwing code.")
}

// Scenario B: Calling with a throwing closure. 'try' IS required!
do {
    try executeTask {
        print("Executing throwing code...")
        throw FileError.fileNotFound
    }
} catch {
    print("Caught error from rethrowing function: \(error)")
}


// MARK: - 4. Swift 6 Typed Throws
print("\n--- 4. Swift 6 Typed Throws ---")

enum ValidationError: Error {
    case nameTooShort
    case emailInvalid
}

// This function is explicitly marked to only throw errors of type ValidationError.
func validateUser(name: String) throws(ValidationError) -> String {
    if name.count < 3 {
        throw ValidationError.nameTooShort
    }
    return "Valid User: \(name)"
}

do {
    // In Swift 6, catching a typed throw ensures the 'error' variable is statically typed.
    let validName = try validateUser(name: "Jo")
    print(validName)
} catch {
    // 'error' is statically typed as 'ValidationError' (not 'any Error')
    // No type casting needed, compile-time checked switch must be exhaustive for ValidationError!
    switch error {
    case .nameTooShort:
        print("Validation failed: Name is too short.")
    case .emailInvalid:
        print("Validation failed: Email is invalid.")
    }
}
