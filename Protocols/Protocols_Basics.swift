import Foundation

// Protocols define a blueprint of methods, properties, and other requirements
protocol Identifiable {
    var id: String { get }
    func displayID()
}

// Struct conforming to Protocol
struct User: Identifiable {
    var id: String
    var name: String
    
    func displayID() {
        print("User ID: \(id)")
    }
}

// Protocol inheritance
protocol Authenticatable: Identifiable {
    func authenticate() -> Bool
}

struct Admin: Authenticatable {
    var id: String
    
    func displayID() {
        print("Admin ID: \(id)")
    }
    
    func authenticate() -> Bool {
        print("Authenticating admin...")
        return true
    }
}

let user = User(id: "USR-001", name: "John")
user.displayID()

let admin = Admin(id: "ADM-99")
admin.displayID()
_ = admin.authenticate()
