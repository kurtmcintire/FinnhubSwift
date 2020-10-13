@testable import Stocks
import XCTest

final class StocksTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Stocks().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
