import Foundation

/*
 Result Builders allow you to build complex objects (like a list or a view hierarchy)
 using a clean, declarative syntax.
*/

struct StyledText {
    let text: String
    let color: String
}

@resultBuilder
struct TextBuilder {
    static func buildBlock(_ components: StyledText...) -> [StyledText] {
        return components
    }
    
    // Support for 'if' statements
    static func buildOptional(_ component: [StyledText]?) -> [StyledText] {
        return component ?? []
    }
    
    // Support for 'if-else' statements
    static func buildEither(first component: [StyledText]) -> [StyledText] {
        return component
    }
    
    static func buildEither(second component: [StyledText]) -> [StyledText] {
        return component
    }
}

struct Document {
    let content: [StyledText]
    
    init(@TextBuilder _ content: () -> [StyledText]) {
        self.content = content()
    }
    
    func render() {
        for item in content {
            print("[\(item.color)] \(item.text)")
        }
    }
}

// Usage
print("--- Result Builders ---")

let isUrgent = true

let myDoc = Document {
    StyledText(text: "Hello", color: "Blue")
    StyledText(text: "World", color: "Green")
    
    if isUrgent {
        StyledText(text: "URGENT ACTION", color: "Red")
    } else {
        StyledText(text: "Normal task", color: "Gray")
    }
}

myDoc.render()
