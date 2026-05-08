import Foundation

// Custom error type
enum NetworkError: Error {
    case invalidURL
    case serverError(code: Int)
    case unauthorized
}

// Function that throws errors
func fetchUser(id: Int) throws -> String {
    if id < 0 {
        throw NetworkError.invalidURL
    }
    
    if id == 0 {
        throw NetworkError.unauthorized
    }
    
    return "User Profile for ID \(id)"
}

// Handling errors with do-catch
do {
    let profile = try fetchUser(id: -1)
    print(profile)
} catch NetworkError.invalidURL {
    print("Error: Invalid URL provided.")
} catch NetworkError.unauthorized {
    print("Error: User is not authorized.")
} catch {
    print("An unknown error occurred: \(error)")
}

// Optional try
let profileOrNil = try? fetchUser(id: 0)
print("Profile or Nil: \(profileOrNil ?? "Nil")")

// Forced try (be careful!)
// let profileOrCrash = try! fetchUser(id: 10) 
