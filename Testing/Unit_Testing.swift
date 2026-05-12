import XCTest

/*
 Unit Testing (XCTest)
 
 Unit testing is the process of testing small, isolated pieces of code (units) to ensure they work as expected.
 XCTest is Apple's framework for writing and running tests in Swift.
 
 Key Concepts:
 1. XCTestCase: The base class for all test classes.
 2. Test Methods: Methods starting with 'test' that contain assertions.
 3. Assertions: Functions like XCTAssertEqual, XCTAssertTrue, etc., used to verify behavior.
 4. setUp() / tearDown(): Methods to prepare/clean up state before/after each test.
*/

// --- Example Code to Test ---

struct MathUtils {
    func add(_ a: Int, _ b: Int) -> Int {
        return a + b
    }
    
    func divide(_ a: Int, _ b: Int) -> Int? {
        guard b != 0 else { return nil }
        return a / b
    }
}

// --- Test Case ---

class MathUtilsTests: XCTestCase {
    
    var mathUtils: MathUtils!
    
    // This method is called before the invocation of each test method in the class.
    override func setUp() {
        super.setUp()
        mathUtils = MathUtils()
    }
    
    // This method is called after the invocation of each test method in the class.
    override func tearDown() {
        mathUtils = nil
        super.tearDown()
    }
    
    func testAddition() {
        // Given (Arrange)
        let a = 5
        let b = 10
        
        // When (Act)
        let result = mathUtils.add(a, b)
        
        // Then (Assert)
        XCTAssertEqual(result, 15, "Addition of 5 and 10 should be 15")
    }
    
    func testDivisionByZero() {
        // When
        let result = mathUtils.divide(10, 0)
        
        // Then
        XCTAssertNil(result, "Division by zero should return nil")
    }
    
    func testSuccessfulDivision() {
        // When
        let result = mathUtils.divide(10, 2)
        
        // Then
        XCTAssertEqual(result, 5)
    }
}

// NOTE: In a real app, you run tests using Cmd+U in Xcode or 'swift test' in terminal.
// For this example, we'll just print that we've defined the tests.
print("--- Unit Testing (XCTest) example defined ---")
print("Tests included: testAddition, testDivisionByZero, testSuccessfulDivision")
