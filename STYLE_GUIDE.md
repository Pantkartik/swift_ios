# Swift Style Guide 🎨

Consistency is key to maintainable and readable code. This guide outlines the conventions used in this repository.

## 📝 General Rules

- **Indentation**: Use 4 spaces (standard Xcode default).
- **Naming**: 
    - Use `PascalCase` for types (Structs, Classes, Enums, Protocols).
    - Use `camelCase` for variables, constants, and functions.
- **Line Length**: Aim for less than 120 characters per line.

## 🛠️ Swift Specifics

### 1. Variables and Constants
- Prefer `let` over `var` whenever possible.
- Use meaningful names (e.g., `userCount` instead of `c`).

### 2. Optionals
- Prefer `if let` or `guard let` for unwrapping.
- Avoid forced unwrapping (`!`) unless absolutely necessary (e.g., @IBOutlet or unit tests where failure is expected).

### 3. Closure Syntax
- Use trailing closure syntax whenever it makes the code more readable.
- Use shorthand argument names (`$0`, `$1`) for very short, simple closures.

### 4. SwiftUI
- Keep `body` properties clean; extract complex views into sub-views or computed properties.
- Use `@State`, `@Binding`, and `@Environment` appropriately for data flow.

## 🧪 Testing
- Test names should be descriptive: `test[FunctionName]_[ExpectedBehavior]`.
- Follow the Given-When-Then pattern in unit tests.

---

*Reference: Inspired by [Apple's API Design Guidelines](https://www.swift.org/documentation/api-design-guidelines/).*
