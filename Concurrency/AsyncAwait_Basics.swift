import Foundation

// Modern Swift Concurrency (Async/Await)
func fetchData() async throws -> String {
    // Simulate network delay
    try await Task.sleep(nanoseconds: 1 * 1_000_000_000)
    return "Data fetched successfully from AI Service"
}

func processData() async {
    do {
        print("Fetching data...")
        let data = try await fetchData()
        print(data)
    } catch {
        print("Failed to fetch data: \(error)")
    }
}

// Entry point for async code in a script
Task {
    await processData()
}

// Keep the script alive for async task to finish (not needed in real iOS app context usually)
RunLoop.main.run(until: Date(timeIntervalSinceNow: 2))
