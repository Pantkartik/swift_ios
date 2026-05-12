import Foundation

/*
 Result Builders (@resultBuilder)
 
 Result builders (formerly Function Builders) allow you to create a Domain-Specific Language (DSL)
 for creating complex objects (like nested arrays or strings) using a natural, declarative syntax.
 
 This is the magic behind SwiftUI's 'ViewBuilder'.
*/

// --- Example: A simple HTML Builder ---

enum HTMLElement {
    case text(String)
    case tag(String, [HTMLElement])
}

@resultBuilder
struct HTMLBuilder {
    // Required: Combines multiple elements into one
    static func buildBlock(_ components: HTMLElement...) -> [HTMLElement] {
        components
    }
    
    // Optional: Supports 'if' statements
    static func buildOptional(_ component: [HTMLElement]?) -> [HTMLElement] {
        component ?? []
    }
    
    // Optional: Supports 'if-else' statements
    static func buildEither(first component: [HTMLElement]) -> [HTMLElement] {
        component
    }
    
    static func buildEither(second component: [HTMLElement]) -> [HTMLElement] {
        component
    }
}

// Function that uses the builder
func body(@HTMLBuilder _ content: () -> [HTMLElement]) -> HTMLElement {
    .tag("body", content())
}

func div(@HTMLBuilder _ content: () -> [HTMLElement]) -> HTMLElement {
    .tag("div", content())
}

func p(_ text: String) -> HTMLElement {
    .text(text)
}

// --- Usage: Declarative Syntax ---

let myPage = body {
    div {
        p("Hello World")
        p("This is a Result Builder example.")
    }
    
    let showSecret = true
    if showSecret {
        p("This is a secret message!")
    }
}

// Helper to print the result
func render(_ element: HTMLElement, indent: String = "") {
    switch element {
    case .text(let text):
        print("\(indent)\(text)")
    case .tag(let name, let children):
        print("\(indent)<\(name)>")
        for child in children {
            render(child, indent: indent + "  ")
        }
        print("\(indent)</\(name)>")
    }
}

print("--- Result Builder Output ---")
render(myPage)

/*
 Summary:
 - Result builders transform a sequence of statements into a single value.
 - They enable the clean, nested syntax found in SwiftUI.
 - You can support loops, conditionals, and more by implementing specific static methods.
*/
