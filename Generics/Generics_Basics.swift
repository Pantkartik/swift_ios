import Foundation

// Generics allow you to write flexible, reusable functions and types
func swapTwoValues<T>(_ a: inout T, _ b: inout T) {
    let temporaryA = a
    a = b
    b = temporaryA
}

var firstInt = 100
var secondInt = 200
swapTwoValues(&firstInt, &secondInt)
print("firstInt: \(firstInt), secondInt: \(secondInt)")

var firstString = "Hello"
var secondString = "World"
swapTwoValues(&firstString, &secondString)
print("firstString: \(firstString), secondString: \(secondString)")

// Generic Types
struct Stack<Element> {
    var items: [Element] = []
    
    mutating func push(_ item: Element) {
        items.append(item)
    }
    
    mutating func pop() -> Element? {
        return items.popLast()
    }
}

var intStack = Stack<Int>()
intStack.push(1)
intStack.push(2)
print("Popped: \(intStack.pop() ?? -1)")
