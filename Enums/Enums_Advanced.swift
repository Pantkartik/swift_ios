import Foundation

// Enumerations in Swift are much more powerful than in other languages.
// They can have associated values of any type.

enum Result<Success, Failure: Error> {
    case success(Success)
    case failure(Failure)
}

enum AppState {
    case idle
    case loading(message: String)
    case success(data: [String])
    case error(code: Int, description: String)
}

func checkStatus(state: AppState) {
    switch state {
    case .idle:
        print("Application is idle.")
    case .loading(let message):
        print("Loading... \(message)")
    case .success(let items):
        print("Success! Received \(items.count) items.")
    case .error(let code, let description):
        print("Error \(code): \(description)")
    }
}

let currentState = AppState.loading(message: "Fetching AI models")
checkStatus(state: currentState)

let resultState = AppState.success(data: ["CoreML", "Vision", "NLP"])
checkStatus(state: resultState)

let failureState = AppState.error(code: 404, description: "Model not found")
checkStatus(state: failureState)
