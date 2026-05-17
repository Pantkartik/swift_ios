# Design Patterns in Swift

This module explores advanced design patterns and architectural approaches in Swift and iOS development, moving beyond MVC (Model-View-Controller) to create scalable, testable, and maintainable applications.

## Architectures

### MVVM (Model-View-ViewModel)
- **Concept:** Separates the business and presentation logic from the View. The ViewModel acts as an intermediary, transforming Model data into View-ready data.
- **Benefits:** Highly testable, works seamlessly with SwiftUI and Combine.

### VIPER
VIPER is an implementation of Clean Architecture for iOS.
- **V**iew: Displays what it is told to by the Presenter and relays user input.
- **I**nteractor: Contains the business logic as specified by a use case.
- **P**resenter: Contains view logic for preparing content for display (as received from the Interactor) and for reacting to user inputs (by requesting new data from the Interactor).
- **E**ntity: Contains basic model objects used by the Interactor.
- **R**outer: Contains navigation logic for describing which screens are shown when.

### Clean Architecture
- **Concept:** Separation of concerns through layers (Presentation, Domain, Data). The inner layers contain business rules, and outer layers contain UI, databases, and APIs.
- **Rule:** Dependencies must only point inward.

## Creational Patterns
- **Singleton:** Ensuring a class has only one instance and provides a global point of access to it.
- **Builder:** Separating the construction of a complex object from its representation.
- **Factory Method:** Creating objects without specifying the exact class of object that will be created.

## Structural Patterns
- **Adapter:** Allowing classes with incompatible interfaces to work together.
- **Decorator:** Attaching additional responsibilities to an object dynamically.
- **Facade:** Providing a unified interface to a set of interfaces in a subsystem.

## Behavioral Patterns
- **Observer:** Defining a one-to-many dependency between objects (often implemented via Combine or NotificationCenter in iOS).
- **Delegate:** A specific Apple pattern where one object acts on behalf of, or in coordination with, another object.
- **Command:** Encapsulating a request as an object.

## Best Practices
- **Dependency Injection:** Passing dependencies into an object rather than creating them internally, improving testability.
- **SOLID Principles:** Adhering to Single Responsibility, Open/Closed, Liskov Substitution, Interface Segregation, and Dependency Inversion principles.
