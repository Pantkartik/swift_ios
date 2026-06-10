// Swift Basics: Variables, Constants, and Printing

// 1. Constants (let)
// Constants are declared using 'let'. Once assigned, their value cannot be changed.
let age = 20
print("age") // Prints the literal string "age"
print(age)   // Prints the value of the constant: 20

// 2. Variables (var)
// Variables are declared using 'var' and their values can be modified later.
var name = "Kartik"
print(name) // Prints "Kartik"

// Modifying the variable value
name = "Pant"
print(name) // Prints "Pant"

// 3. Constants vs Variables
// In Swift, 'const' is not a valid keyword. We use 'let' instead of 'const'.
let gravity = 9.8
print(gravity)

// The line below is commented out because it causes a compile-time error:
// "Cannot assign to value: 'gravity' is a 'let' constant"
// gravity = 10.0