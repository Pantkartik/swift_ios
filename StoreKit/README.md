# StoreKit 2 🛒

StoreKit 2 is Apple's modern framework (introduced in iOS 15 / macOS 12) for integrating In-App Purchases (IAP) and Subscriptions. It replaces the older, delegate-based StoreKit APIs with swift-concurrency-native patterns (`async/await`, `AsyncSequence`).

## Core Concepts

- **Product**: Represents a purchase item defined in App Store Connect. Product types include:
  - *Consumable*: Consumed after use (e.g., in-game coins, extra lives).
  - *Non-Consumable*: Purchased once and kept forever (e.g., premium filters, ad-free upgrade).
  - *Auto-Renewable Subscription*: Periodic billing, automatic renewal (e.g., monthly service).
  - *Non-Renewing Subscription*: Periodic billing, manual renewal (e.g., a one-season pass).
- **Transaction**: An object representing a successful purchase. StoreKit 2 handles verification automatically and wraps transactions in `VerificationResult`.
- **VerificationResult**: An enum (`.verified(T)` or `.unverified(T, Error)`) indicating if Apple verified the cryptographically signed transaction.
- **Transaction.updates**: An `AsyncSequence` that delivers real-time transaction events (e.g., purchases finished outside the app, updates from subscription renewals).

## In-App Purchase Flow

1. **Request Products**: Fetch products using a set of Product IDs:
   ```swift
   let products = try await Product.products(for: ["com.example.premium"])
   ```
2. **Purchase**: Call `purchase()` on the `Product` instance:
   ```swift
   let result = try await product.purchase()
   ```
3. **Verify and Grant**: Inspect the purchase result. If successful and verified, grant user access to the content and **finish** the transaction:
   ```swift
   switch result {
   case .success(let verificationResult):
       let transaction = try checkVerified(verificationResult)
       await grantAccess(to: transaction)
       await transaction.finish()
   case .pending, .userCancelled:
       break
   }
   ```

## Local Testing
Always use a StoreKit Configuration File (`.storekit` file) in Xcode for fast, offline testing. You can define products, subscriptions, and simulate transactions, refunds, and renewals inside Xcode previews or local simulator runs.

---

*See `StoreKit_Example.swift` for a full local StoreKit 2 management class.*
