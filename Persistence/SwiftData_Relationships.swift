import Foundation
import SwiftData

/*
 SwiftData Relationships
 
 One of the most powerful features of any persistence layer is handling relationships between models.
 SwiftData uses the @Relationship macro to define how models interact.
*/

@Model
class Category {
    var name: String
    
    // One-to-Many Relationship
    // When a Category is deleted, all its tasks are also deleted (.cascade)
    @Relationship(deleteRule: .cascade, inverse: \TaskItem.category)
    var tasks: [TaskItem] = []
    
    init(name: String) {
        self.name = name
    }
}

@Model
class TaskItem {
    var title: String
    var isDone: Bool
    
    // The inverse relationship back to Category
    var category: Category?
    
    // Many-to-Many Relationship
    // A Task can have multiple Tags, and a Tag can be in multiple Tasks.
    @Relationship(inverse: \Tag.tasks)
    var tags: [Tag] = []
    
    init(title: String, isDone: Bool = false) {
        self.title = title
        self.isDone = isDone
    }
}

@Model
class Tag {
    var name: String
    var tasks: [TaskItem] = []
    
    init(name: String) {
        self.name = name
    }
}

/*
 Delete Rules:
 - .nullify: (Default) Sets the relationship property to nil in the related models.
 - .cascade: Deletes the related models when the parent model is deleted.
 - .deny: Prevents deletion of the model if it has any related models.
 - .noAction: Performs no action on the related models.
*/

print("--- SwiftData Relationships ---")
print("Defined Category, TaskItem, and Tag models.")
print("Demonstrated One-to-Many relationship between Category and TaskItem.")
print("Demonstrated Many-to-Many relationship between TaskItem and Tag.")
print("Delete rule set to .cascade for Category -> Tasks.")
