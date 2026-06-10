let age = 20

// Standard if-else control flow
if age >= 18 {
    print("Eligible for vote")
} else if age <= 0 {
    print("Invalid age! Enter a valid age")
} else {
    print("Not eligible for vote")
}

// Ternary operator: condition ? valueIfTrue : valueIfFalse
// Note: String literals must be enclosed in double quotes.
let result = age >= 19 ? "Eligible to vote" : "Not eligible to vote"

print(result)