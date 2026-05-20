# Closures in Swift 🪢

Closures are self-contained blocks of functionality that can be passed around and used in your code. Closures in Swift are similar to blocks in C and Objective-C and to lambdas in other programming languages.

## 📄 Contents

- `Closures.swift`: Basic syntax and examples.
- `Parameterized_closure.swift`: Closures that accept arguments.
- `shorthand_closures.swift`: Using shorthand argument names like `$0`, `$1`.
- `Closure_array/`: Examples of using closures with collection functions like `map`, `filter`, and `reduce`.

## 💡 Key Concepts
- **Escaping Closures**: Closures that are called after the function they were passed to returns (marked with `@escaping`).
- **Trailing Closures**: If a closure is the last argument to a function, it can be written outside the parentheses.
- **Capture Lists**: Capturing values from the surrounding context, and managing memory safely (e.g., `[weak self]`).
