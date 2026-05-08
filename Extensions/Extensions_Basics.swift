import Foundation

// Extensions add new functionality to an existing class, structure, enumeration, or protocol type.

// 1. Extending built-in types
extension String {
    func isEmail() -> Bool {
        return self.contains("@") && self.contains(".")
    }
    
    var wordCount: Int {
        return self.components(separatedBy: .whitespacesAndNewlines).count
    }
}

let myText = "hello@example.com"
print("Is Email: \(myText.isEmail())")
print("Word count: \(myText.wordCount)")

// 2. Extending your own types
struct Point {
    var x: Double
    var y: Double
}

extension Point {
    func distanceToOrigin() -> Double {
        return sqrt(x*x + y*y)
    }
}

let p = Point(x: 3, y: 4)
print("Distance: \(p.distanceToOrigin())")

// 3. Protocol Extensions (Default implementations)
protocol Greetable {
    func sayHello()
}

extension Greetable {
    func sayHello() {
        print("Hello from Protocol Extension!")
    }
}

struct Person: Greetable {}
let me = Person()
me.sayHello() // Uses default implementation
