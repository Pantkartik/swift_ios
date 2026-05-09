import Foundation

/*
 URLSession is the standard way to perform network requests in Swift.
 We use Codable to easily transform JSON into Swift objects.
*/

struct Post: Codable, Identifiable {
    let id: Int
    let title: String
    let body: String
}

enum NetworkError: Error {
    case invalidURL
    case requestFailed
    case decodingFailed
}

class NetworkManager {
    static let shared = NetworkManager()
    
    func fetchPosts() async throws -> [Post] {
        let urlString = "https://jsonplaceholder.typicode.com/posts"
        
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }
        
        // Using the new async/await URLSession API
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw NetworkError.requestFailed
        }
        
        do {
            let decoder = JSONDecoder()
            let posts = try decoder.decode([Post].self, from: data)
            return posts
        } catch {
            throw NetworkError.decodingFailed
        }
    }
}

// Usage
print("--- Networking with URLSession ---")

Task {
    do {
        let posts = try await NetworkManager.shared.fetchPosts()
        print("Fetched \(posts.count) posts.")
        if let first = posts.first {
            print("First Post Title: \(first.title)")
        }
    } catch {
        print("Error fetching posts: \(error)")
    }
}

// Keep script alive
RunLoop.main.run(until: Date(timeIntervalSinceNow: 2))
