# Localization in Swift 🌍

Modern localization using String Catalogs (`.xcstrings`) and the `String(localized:)` API.

## 🚀 Overview

Localization in iOS has evolved from legacy `.strings` files to powerful String Catalogs. This directory covers the implementation of localized strings, pluralization, and device-specific variations.

## 🛠️ Key Concepts

### String Catalogs (.xcstrings)
- Centralized management of all translations.
- Automatic extraction of strings from code.
- Support for pluralization (One, Other, Zero, etc.).
- Device-specific overrides (iPhone vs. iPad).

### String(localized:)
The modern API for localizing strings in Swift.
- `String(localized: "Key")`
- `String(localized: "Key", defaultValue: "Default")`
- `String(localized: "Key", comment: "Context for translators")`

## 📂 Implementation Examples

- `LocalizationExample.swift`: Demonstrates basic usage, interpolation, and pluralization handling in code.

## 🔧 Setup in Xcode
1. **Enable Extraction**: Set "Use Compiler to Extract Swift Strings" to `YES` in Build Settings.
2. **Create Catalog**: Add a new "String Catalog" file named `Localizable.xcstrings`.
3. **Build**: Build the project to populate the catalog automatically.
