import Foundation

// 1. Generic Constraints
// Restricting types to those that inherit from a class or conform to a protocol

protocol Drawable {
    func draw()
}

struct Circle: Drawable {
    func draw() { print("Drawing a Circle") }
}

struct Square: Drawable {
    func draw() { print("Drawing a Square") }
}

// T must conform to Drawable
func render<T: Drawable>(_ item: T) {
    item.draw()
}

// 2. Multiple Constraints and 'where' Clauses
func compareAndRender<T: Drawable & Equatable>(_ item1: T, _ item2: T) {
    if item1 == item2 {
        print("Rendering identical items:")
        item1.draw()
    } else {
        print("Items are different")
    }
}

// Extension to make Circle Equatable for the example
extension Circle: Equatable {
    static func == (lhs: Circle, rhs: Circle) -> Bool {
        return true // Simplified for example
    }
}

// 3. Generic Subscripts
struct GenericDictionary<Key: Hashable, Value> {
    private var data: [Key: Value] = [:]
    
    subscript<T>(key: Key) -> T? where T == Value {
        get { return data[key] as? T }
        set { data[key] = newValue }
    }
}

// 4. Opaque Types (some Keyword)
// Returning an object without exposing its concrete type, but maintaining identity
func makeDefaultShape() -> some Drawable {
    return Circle()
}

// 5. Type Erasure (Brief Concept)
// Useful when you need to store heterogeneous types that conform to a protocol with associated types
protocol Fetcher {
    associatedtype DataType
    func fetch() -> DataType
}

struct AnyFetcher<T>: Fetcher {
    private let _fetch: () -> T
    
    init<F: Fetcher>(_ fetcher: F) where F.DataType == T {
        _fetch = fetcher.fetch
    }
    
    func fetch() -> T {
        return _fetch()
    }
}

// Usage
print("--- Advanced Generics ---")
let circle = Circle()
render(circle)

let shape = makeDefaultShape()
shape.draw()

var dict = GenericDictionary<String, Int>()
dict["score"] = 100
print("Score: \(dict["score"] ?? 0)")
