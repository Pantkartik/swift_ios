# Optionals in Swift ❓

Optionals say either "there is a value, and it equals x" or "there isn't a value at all". Optionals are fundamental to Swift and provide compile-time safety against `nil` values.

## 📄 Contents

- `optionals.swift`: Basic usage of optionals, optional binding (`if let`), and forced unwrapping.
- `optionals.md`: Brief notes on why optionals are used in Swift for safety.

## 💡 Key Concepts
- **Optional Binding**: Using `if let` or `guard let` to safely unwrap an optional.
- **Forced Unwrapping**: Using `!` to access the value if you are absolutely sure it exists (can crash if `nil`).
- **Nil-Coalescing Operator**: Using `??` to provide a default value when an optional is `nil`.
- **Optional Chaining**: Safely calling properties or methods on an optional that might be `nil`.
