import Foundation
import SwiftData

/*
 SwiftData Schema Migrations
 
 As your app evolves, your data models will change. 
 SwiftData provides a structured way to migrate data between different versions of your schema.
*/

// MARK: - Version 1 Schema
enum TodoSchemaV1: VersionedSchema {
    static var versionIdentifier = Schema.Version(1, 0, 0)
    
    static var models: [any PersistentModel.Type] {
        [TodoItem.self]
    }
    
    @Model
    class TodoItem {
        var title: String
        var createdAt: Date
        
        init(title: String, createdAt: Date = .now) {
            self.title = title
            self.createdAt = createdAt
        }
    }
}

// MARK: - Version 2 Schema (Adding priority)
enum TodoSchemaV2: VersionedSchema {
    static var versionIdentifier = Schema.Version(1, 1, 0)
    
    static var models: [any PersistentModel.Type] {
        [TodoItem.self]
    }
    
    @Model
    class TodoItem {
        var title: String
        var createdAt: Date
        var priority: Int = 0 // New field added
        
        init(title: String, createdAt: Date = .now, priority: Int = 0) {
            self.title = title
            self.createdAt = createdAt
            self.priority = priority
        }
    }
}

// MARK: - Migration Plan
enum TodoMigrationPlan: SchemaMigrationPlan {
    static var stages: [MigrationStage] {
        [migrateV1toV2]
    }
    
    static var schemas: [any VersionedSchema.Type] {
        [TodoSchemaV1.self, TodoSchemaV2.self]
    }
    
    static let migrateV1toV2 = MigrationStage.lightweight(
        fromVersion: TodoSchemaV1.self,
        toVersion: TodoSchemaV2.self
    )
    
    /*
     For custom migrations (non-lightweight):
     static let customMigrate = MigrationStage.custom(
         fromVersion: TodoSchemaV1.self,
         toVersion: TodoSchemaV2.self,
         willMigrate: { context in ... },
         didMigrate: { context in ... }
     )
    */
}

/*
 Usage in App:
 
 let container = try ModelContainer(
    for: TodoSchemaV2.TodoItem.self,
    migrationPlan: TodoMigrationPlan.self,
    configurations: ModelConfiguration(for: TodoSchemaV2.TodoItem.self)
 )
*/

print("--- SwiftData Migrations ---")
print("Defined versioned schemas: V1 and V2.")
print("Implemented a lightweight migration plan to move from V1 to V2.")
print("SwiftData handles simple migrations (like adding optional/default fields) automatically if configured.")
