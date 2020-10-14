@testable import FinnhubSwift
import XCTest

final class SafeURLTests: XCTestCase {
    func testThatItCreatesSafeURLs() {
        let strings = [
            "https://google.com",
            "https://finnhub.io",
            "https://finnhub.io/api/v1",
            "https://finnhub.io/api/v1/news?category=general&token=123",
        ]
        for string in strings {
            testThatItCreatesSafeURL(string: string)
        }
    }

    func testThatItCreatesSafeURL(string: String) {
        let url = SafeURL.path(string)
        XCTAssertNotNil(url)
    }
}
