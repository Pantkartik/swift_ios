# CloudKit Integration

CloudKit is Apple's framework for moving data between your app and your iCloud containers.

## Core Concepts

- **Containers:** The highest level of organization. An app typically has one default container but can access others.
- **Databases:** Each container has three databases:
  - **Public:** Accessible to all users of the app.
  - **Private:** Accessible only to the currently logged-in iCloud user.
  - **Shared:** Used for sharing data between users.
- **Records (CKRecord):** The fundamental unit of data in CloudKit. Think of it as a row in a database table or a JSON dictionary. Records have a type and fields.
- **Zones:** Logical groupings of records within a database. Private and shared databases have custom zones, while the public database only has a default zone.

## Workflow

1.  **Enable CloudKit:** In Xcode, go to Signing & Capabilities and add the iCloud capability with the CloudKit service enabled.
2.  **Dashboard:** Use the CloudKit Console (Dashboard) to manage schemas, view records, and configure security roles.
3.  **Fetching Data:** Use `CKQueryOperation` or `CKDatabase.perform(_:inZoneWith:)` to query for records.
4.  **Saving Data:** Create a `CKRecord`, set its values, and save it using `CKDatabase.save(_:completionHandler:)` or `CKModifyRecordsOperation`.

## Advanced Features

- **Subscriptions (CKSubscription):** Allow your app to receive push notifications when data changes on the server. Useful for keeping local data in sync.
- **Syncing:** CloudKit is not an automatic offline-first sync engine. You must manually handle conflicts and synchronization logic unless you use it in conjunction with Core Data (NSPersistentCloudKitContainer) or SwiftData.
- **Assets (CKAsset):** Used for storing large binary files (like images or videos) separately from the record data.

## SwiftData & CloudKit

SwiftData natively supports syncing with CloudKit via `ModelConfiguration`.
- The schema must be compatible with CloudKit (e.g., all properties must be optional or have default values, no unique constraints).
- Requires the use of the Private Database and Custom Zones.

## Best Practices

- **Batch Operations:** Use `CKModifyRecordsOperation` to save or delete multiple records at once to reduce network requests.
- **Error Handling:** CloudKit operations can fail for various reasons (network issues, quota exceeded, conflicts). Robust error handling is essential.
- **Pagination:** When fetching large amounts of data, use the `cursor` property of `CKQueryOperation` to fetch data in pages.
