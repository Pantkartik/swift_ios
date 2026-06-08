# Swift Charts 📊

Introduced in iOS 16 / macOS 13, Swift Charts is a powerful, declarative charting framework that allows developers to design charts using a descriptive syntax similar to SwiftUI. It automatically handles scaling, labeling, dark mode, accessibility, and localization out-of-the-box.

## Key Concepts

- **Chart**: The top-level view container that layout marks.
- **Marks**: The visual building blocks of a chart. You combine them to form different types of plots:
  - **BarMark**: Renders vertical or horizontal bars. Suitable for comparisons.
  - **LineMark**: Renders continuous lines. Best for tracking data over time.
  - **AreaMark**: Renders filled shapes beneath a boundary. Used to display volumes or stacked layers.
  - **PointMark**: Renders dots at specific coordinates. Ideal for scatter plots or highlighting coordinate values.
  - **RuleMark**: Renders horizontal or vertical gridlines. Great for marking averages, targets, or limits.
- **Value Mapping**: Data points are mapped to axes using the `.value` construct:
  ```swift
  BarMark(
      x: .value("Month", "Jan"),
      y: .value("Sales", 1450)
  )
  ```

## Styling & Customization

Swift Charts offers highly flexible modifiers:
- **Grouping Styles**: Group series automatically with `.foregroundStyle(by: .value("Category", item.category))`. The chart will generate an automatic legend.
- **Line Smoothing**: Smooth line edges using `.interpolationMethod(.catmullRom)`.
- **Chart Axes**: Customize axis labels, lines, and grids using `.chartXAxis { ... }` and `.chartYAxis { ... }`.

## User Interaction (iOS 17+)

You can make charts interactive by binding directly to gestures:
- **Selection Bindings**: Use `.chartXSelection(value: $selectedValue)` to detect where a user is tapping/dragging. This lets you render dynamic tooltips showing precise statistics.

---

*See `SwiftCharts_Example.swift` for interactive bar and line chart implementations.*
