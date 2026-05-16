# Performance Optimization in Swift ⚡

Ensuring your apps run smoothly and efficiently on all devices.

## 🛠️ Tools & Frameworks

### Xcode Instruments
The primary tool for profiling and optimizing your applications.
- **Time Profiler**: Identify CPU bottlenecks and find heavy methods.
- **Leaks**: Detect memory leaks and retain cycles.
- **Allocations**: Track memory usage over time.
- **SwiftUI Instrument**: Profile view body executions and state changes.

### MetricKit
Receive on-device power and performance metrics from the system.

## 📂 Implementation Examples

- `MemoryLeakExample.swift`: Demonstrates a common retain cycle and how to fix it using `weak` references.

## 💡 Best Practices

1. **Lazy Loading**: Use `lazy` properties for expensive-to-create objects.
2. **View Optimization**: Avoid complex calculations in the `body` of SwiftUI views.
3. **Image Handling**: Downsample images before displaying them in lists.
4. **Background Tasks**: Move heavy processing off the main thread using Swift Concurrency (`Task.detached` or `Task`).
