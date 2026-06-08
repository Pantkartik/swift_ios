import StoreKit
import SwiftUI

// MARK: - Store Manager
/// A `@MainActor` class to manage in-app purchases and track transaction status.
@MainActor
final class StoreManager: ObservableObject {
    
    // Published states to drive SwiftUI views
    @Published private(set) var products: [Product] = []
    @Published private(set) var purchasedProductIDs: Set<String> = []
    
    // Task listener for asynchronous transaction events from the App Store
    private var transactionListener: Task<Void, Error>?
    
    // Mock Product IDs matching App Store Connect or Xcode config
    private let productIDs = [
        "com.example.app.premium_monthly",
        "com.example.app.remove_ads",
        "com.example.app.tip_jar_small"
    ]
    
    init() {
        // Start listening to the Transaction update stream at app startup.
        transactionListener = listenForTransactions()
        
        // Load initial products and user entitlements
        Task {
            await loadProducts()
            await updatePurchaseStatus()
        }
    }
    
    deinit {
        // Cancel the task listener when the manager is destroyed
        transactionListener?.cancel()
    }
    
    // MARK: - Fetch Products
    /// Requests the list of products from the App Store.
    func loadProducts() async {
        do {
            // StoreKit 2 fetches metadata for products from Apple servers or local .storekit file
            let fetchedProducts = try await Product.products(for: productIDs)
            
            // Sort by price ascending
            self.products = fetchedProducts.sorted(by: { $0.price < $1.price })
        } catch {
            print("Failed to fetch products from App Store: \(error)")
        }
    }
    
    // MARK: - Purchase Flow
    /// Initiates a purchase for a given product and returns true if completed successfully.
    func purchase(_ product: Product) async -> Bool {
        do {
            let result = try await product.purchase()
            
            switch result {
            case .success(let verificationResult):
                // Verify that the signature is valid and hasn't been tampered with
                let transaction = try checkVerified(verificationResult)
                
                // Grant access to the feature
                await updatePurchaseStatus()
                
                // IMPORTANT: Always finish the transaction to remove it from the App Store queue
                await transaction.finish()
                return true
                
            case .userCancelled:
                print("User cancelled purchase.")
                return false
                
            case .pending:
                print("Purchase pending parental approval or banking system authorization.")
                return false
                
            @unknown default:
                return false
            }
        } catch {
            print("Purchase failed: \(error)")
            return false
        }
    }
    
    // MARK: - Update Entitlements
    /// Checks what products the user currently owns.
    func updatePurchaseStatus() async {
        var purchased: Set<String> = []
        
        // Transaction.currentEntitlements contains all verified active transactions (subscriptions + non-consumables)
        for await result in Transaction.currentEntitlements {
            do {
                let transaction = try checkVerified(result)
                
                // Add the productID to the active purchased set
                purchased.insert(transaction.productID)
            } catch {
                print("Entitlement verification failed: \(error)")
            }
        }
        
        self.purchasedProductIDs = purchased
    }
    
    // MARK: - Background Transaction Listener
    /// Continuously listens for transactions completed outside the immediate app purchase flow.
    private func listenForTransactions() -> Task<Void, Error> {
        Task.detached(priority: .background) {
            for await result in Transaction.updates {
                do {
                    let transaction = try await self.checkVerified(result)
                    
                    // Always perform UI updates on the @MainActor
                    await self.updatePurchaseStatus()
                    
                    // Finish the transaction
                    await transaction.finish()
                } catch {
                    print("Background transaction update failed: \(error)")
                }
            }
        }
    }
    
    // MARK: - Verification Helper
    /// Validates the cryptographic signatures of StoreKit transactions.
    func checkVerified<T>(_ result: VerificationResult<T>) throws -> T {
        switch result {
        case .unverified(_, let error):
            // The signature is invalid - ignore or reject the purchase
            throw error
        case .verified(let safeValue):
            // Transaction successfully verified by Apple
            return safeValue
        }
    }
}

// MARK: - SwiftUI Presentation
struct StoreKit_ExampleView: View {
    @StateObject private var storeManager = StoreManager()
    
    var body: some View {
        NavigationStack {
            List {
                Section("Available Features") {
                    if storeManager.products.isEmpty {
                        Text("Loading Products...")
                            .foregroundColor(.secondary)
                    } else {
                        ForEach(storeManager.products) { product in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(product.displayName)
                                        .font(.headline)
                                    Text(product.description)
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                                
                                Spacer()
                                
                                if storeManager.purchasedProductIDs.contains(product.id) {
                                    Text("Purchased")
                                        .font(.subheadline)
                                        .bold()
                                        .foregroundColor(.green)
                                } else {
                                    Button(action: {
                                        Task {
                                            _ = await storeManager.purchase(product)
                                        }
                                    }) {
                                        Text(product.displayPrice)
                                            .bold()
                                            .foregroundColor(.white)
                                            .padding(.horizontal, 16)
                                            .padding(.vertical, 8)
                                            .background(Color.blue)
                                            .cornerRadius(8)
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                            .padding(.vertical, 4)
                        }
                    }
                }
                
                Section {
                    Button("Restore Purchases") {
                        Task {
                            // Sync transactions manually in case of device upgrades/transfers
                            try? await AppStore.sync()
                            await storeManager.updatePurchaseStatus()
                        }
                    }
                }
            }
            .navigationTitle("Premium Shop 🛒")
        }
    }
}

#Preview {
    StoreKit_ExampleView()
}
