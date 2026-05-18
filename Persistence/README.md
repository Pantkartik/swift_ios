# Persistence in iOS 💾

This directory covers local data storage and persistence solutions in Swift and iOS.

## Overview
Apps often need to save data locally to work offline, improve performance by caching data, or save user preferences. iOS provides several frameworks for persisting data, from simple key-value stores to full relational databases.

## Core Technologies
- **UserDefaults**: Ideal for storing small amounts of user preferences and settings (key-value pairs).
- **FileManager**: Storing files directly to the disk, such as images, PDFs, or JSON files.
- **CoreData**: Apple's powerful and mature object graph and persistence framework.
- **SwiftData**: The modern, Swift-native framework introduced as a successor to CoreData, offering a more declarative approach.
- **SQLite**: A C-language library that implements a small, fast, self-contained, high-reliability, full-featured, SQL database engine.
- **Realm / Third-Party Databases**: Popular alternatives to Apple's native solutions, often prized for speed and cross-platform capabilities.

## Best Practices
- **Security**: Use the Keychain for sensitive information like passwords, tokens, or encryption keys. Never store them in UserDefaults.
- **Performance**: Perform database operations on background threads to avoid blocking the main UI thread.
- **Migrations**: Plan for database schema changes and implement proper migration strategies.
- **Data Modeling**: Design your data models carefully to avoid complex and slow queries.
