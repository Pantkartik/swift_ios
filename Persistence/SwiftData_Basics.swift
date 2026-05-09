import Foundation
import SwiftData

/*
 SwiftData is the modern replacement for CoreData.
 It uses macros to define models and is deeply integrated with SwiftUI.
*/

@Model
class TodoItem {
    var title: String
    var isCompleted: Bool
    var createdAt: Date
    
    init(title: String, isCompleted: Bool = false, createdAt: Date = .now) {
        self.title = title
        self.isCompleted = isCompleted
        self.createdAt = createdAt
    }
}

/*
 Note: In a real app, you would set up a ModelContainer in your App struct:
 
 @main
 struct TodoApp: App {
     var body: some Scene {
         WindowGroup {
             ContentView()
         }
         .modelContainer(for: TodoItem.self)
     }
 }
*/

print("--- SwiftData Persistence ---")

// Conceptual CRUD operations
/*
 @Environment(\.modelContext) private var modelContext
 @Query private var items: [TodoItem]
 
 // Create
 let newItem = TodoItem(title: "Learn SwiftData")
 modelContext.insert(newItem)
 
 // Delete
 modelContext.delete(item)
*/

print("Defined TodoItem model using SwiftData macros.")
print("SwiftData simplifies data persistence by using plain Swift classes.")
