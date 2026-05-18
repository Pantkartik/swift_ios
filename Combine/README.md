# Combine Framework 🔄

This directory covers the Combine framework in Swift, an Apple framework for processing values over time.

## Overview
Combine provides a declarative Swift API for processing values over time. These values can represent many kinds of asynchronous events. Combine declares publishers to expose values that can change over time, and subscribers to receive those values from the publishers.

## Topics Covered
- **Publishers and Subscribers**: The core components of Combine.
- **Operators**: Transforming, filtering, and combining data streams (e.g., `map`, `filter`, `merge`).
- **Subjects**: `PassthroughSubject` and `CurrentValueSubject`.
- **Cancellables**: Managing memory and the lifecycle of subscriptions.
- **Error Handling in Combine**: Handling and mapping errors within a reactive stream.
- **Integration with SwiftUI**: Using `@Published`, `ObservableObject`, and the `onReceive` modifier.

## Resources
- [Apple Developer: Combine](https://developer.apple.com/documentation/combine)
