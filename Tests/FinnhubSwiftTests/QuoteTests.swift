@testable import FinnhubSwift
import XCTest

final class QuoteTests: XCTestCase {
    func testThatItCreatesAQuote() {
        let notJsonString = Data("Hello".utf8)
        let wrongShape = Data("""
            [
              "AAPL",
              "EMC",
              "HPQ",
              "DELL",
              "WDC",
              "HPE",
              "NTAP",
              "CPQ",
              "SNDK",
              "SEG"
            ]
        """.utf8)
        let partial = Data("""
         {
           "c": 261.74,
           "h": 263.31,
           "l": 260.68,
         }
        """.utf8)
        let full = Data("""
             {
               "c": 261.74,
               "h": 263.31,
               "l": 260.68,
               "o": 261.07,
               "pc": 259.45,
               "t": 1582641000
             }
        """.utf8)

        let data: [CodableTester] = [
            CodableTester(payload: full, expect: true),
            CodableTester(payload: partial, expect: false),
            CodableTester(payload: wrongShape, expect: false),
            CodableTester(payload: notJsonString, expect: false),
        ]

        for datum in data {
            testThatItCreatesAQuote(data: datum)
        }
    }

    func testThatItCreatesAQuote(data: CodableTester) {
        let quote = try? JSONDecoder().decode(Quote.self, from: data.payload)
        if data.expect {
            XCTAssertNotNil(quote)
        } else {
            XCTAssertNil(quote)
        }
    }

    func testThatEquatable() {
        let fixture1 = Quote(open: 261.07, high: 263.31, low: 260.68, current: 261.74, previousClose: 259.45, timestamp: 158_264_100)
        let fixture2 = Quote(open: 261.07, high: 263.31, low: 260.68, current: 261.74, previousClose: 259.45, timestamp: 158_264_100)
        XCTAssertEqual(fixture1, fixture2)
    }

    func testThatHashable() {
        let fixture1 = Quote(open: 261.07, high: 263.31, low: 260.68, current: 261.74, previousClose: 259.45, timestamp: 158_264_100)
        let fixture2 = Quote(open: 261.07, high: 263.31, low: 260.68, current: 261.74, previousClose: 259.45, timestamp: 158_264_100)
        let fixtures: Set<Quote> = [fixture1, fixture2]

        XCTAssertTrue(fixtures.contains(fixture1))
        XCTAssertTrue(fixtures.contains(fixture2))
    }
}
