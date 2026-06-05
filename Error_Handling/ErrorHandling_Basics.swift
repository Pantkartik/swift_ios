import Foundation

/// Swift Error Handling Basics
///
/// This file covers:
/// 1. Custom Error Types (conforming to `Error`)
/// 2. Declaring throwing functions (`throws`)
/// 3. Propagating and handling errors (`do-catch`, `try`)
/// 4. Optional and forced unwrapping of errors (`try?`, `try!`)

// 1. Defining a custom error type using an enum
enum NetworkError: Error {
    case invalidURL
    case serverError(code: Int)
    case unauthorized
}

// 2. A function that can throw an error
func fetchUser(id: Int) throws -> String {
    if id < 0 {
        throw NetworkError.invalidURL
    }
    
    if id == 0 {
        throw NetworkError.unauthorized
    }
    
    return "User Profile for ID \(id)"
}

print("--- 3. Handling errors with do-catch ---")
do {
    let profile = try fetchUser(id: -1)
    print("Success: \(profile)")
} catch NetworkError.invalidURL {
    print("Caught Error: Invalid URL provided.")
} catch NetworkError.unauthorized {
    print("Caught Error: User is not authorized.")
} catch {
    print("Caught Unknown Error: \(error)")
}

print("\n--- 4. Optional Try (try?) ---")
// try? returns an optional. If the function throws, it returns nil.
let profileOrNil = try? fetchUser(id: 0)
print("Profile or Nil result: \(profileOrNil ?? "nil")")

let profileSuccess = try? fetchUser(id: 42)
print("Profile success result: \(profileSuccess ?? "nil")")

print("\n--- 5. Forced Try (try!) ---")
// try! asserts that the function will not throw. If it throws, it crashes.
// Safe here because we pass a valid ID of 10.
let profileOrCrash = try! fetchUser(id: 10) 
print("Forced try success: \(profileOrCrash)")
