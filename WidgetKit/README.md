# WidgetKit 📱

WidgetKit allows users to place small, glanceable blocks of information directly on their iOS Home Screen, Lock Screen (on iOS 16+), and macOS Notification Center. Widgets are build using SwiftUI and are updated over time via a timeline mechanism.

## Key Concepts

- **TimelineEntry**: A data structure containing a `Date` representing when the widget should display this specific state, alongside any custom data.
- **TimelineProvider**: The engine that drives the widget. It tells WidgetKit when to update the widget's content by providing a sequence of `TimelineEntry` objects.
- **WidgetConfiguration**: Defines the widget's metadata, such as its unique identifier, display name, description, and the views it supports.
  - **StaticConfiguration**: For widgets that do not require user configuration (e.g., showing generic top news).
  - **AppIntentConfiguration**: For widgets that can be configured by the user (e.g., choosing a specific stock to track).
- **WidgetFamily**: The size/shape format of the widget.
  - **iOS/macOS Families**: `.systemSmall`, `.systemMedium`, `.systemLarge`, `.systemExtraLarge`
  - **Accessory Families (Lock Screen / watchOS)**: `.accessoryCircular`, `.accessoryRectangular`, `.accessoryInline`

## Widget Lifecycle & Refresh Budget

Widgets do not run continuously. Instead:
1. Your app or Widget Extension schedules a **Timeline** containing entries for the future.
2. The operating system pre-renders these entries at the specified times.
3. The system imposes a daily **Refresh Budget** (typically ~40-70 updates per day depending on user usage) to conserve battery and CPU.
4. Active apps can request immediate updates using `WidgetCenter.shared.reloadAllTimelines()`.

---

*See `WidgetKit_Example.swift` for a complete WidgetKit implementation.*
