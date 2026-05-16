import Foundation

/// A demonstration of a memory leak (retain cycle) and its fix.
/// To profile this, use the 'Leaks' template in Xcode Instruments.

class Parent {
    var child: Child?
    
    init() {
        print("Parent initialized")
    }
    
    deinit {
        print("Parent deinitialized")
    }
}

class Child {
    // ❌ LEAK: Strong reference to parent creates a retain cycle.
    // var parent: Parent?
    
    // ✅ FIX: Use a weak reference to break the cycle.
    weak var parent: Parent?
    
    init(parent: Parent) {
        self.parent = parent
        print("Child initialized")
    }
    
    deinit {
        print("Child deinitialized")
    }
}

func demonstrateLeak() {
    var p: Parent? = Parent()
    var c: Child? = Child(parent: p!)
    
    p?.child = c
    
    // Setting both to nil should deinitialize them.
    // If 'parent' in Child was strong, they would never be deinitialized.
    p = nil
    c = nil
}
