@testable import FinnhubSwift
import XCTest

final class SplitTests: XCTestCase {
    func testThatItCreatesSplits() {
        let splitNotJsonString = Data("Hello".utf8)
        let splitWrong = Data("""
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
        let splitPartial = Data("""
            [{
                 "code2":"NR",
                 "code3":"NRU",
                 "codeNo":"520",
            }]
        """.utf8)
        let splitOne = Data("""
            [{
                "symbol":"AAPL",
                "date":"2014-06-09",
                "fromFactor":1,"toFactor":7
            }]
        """.utf8)

        let splitMany = Data("""
            [
                {
                    "symbol":"AAPL",
                    "date":"2014-06-09",
                    "fromFactor":1,
                    "toFactor":7
                },
                {
                    "symbol":"TSLA",
                    "date":"2014-06-09",
                    "fromFactor":1,
                    "toFactor":7
                }
            ]
        """.utf8)

        let data: [CodableTester] = [
            CodableTester(payload: splitMany, expect: true),
            CodableTester(payload: splitOne, expect: true),
            CodableTester(payload: splitPartial, expect: false),
            CodableTester(payload: splitWrong, expect: false),
            CodableTester(payload: splitNotJsonString, expect: false),
        ]

        for datum in data {
            testThatItCreates(data: datum)
        }
    }

    func testThatItCreates(data: CodableTester) {
        let result = try? JSONDecoder().decode([Split].self, from: data.payload)
        if data.expect {
            XCTAssertNotNil(result)
        } else {
            XCTAssertNil(result)
        }
    }

    func testThatEquatable() {
        let fixture1 = Split(symbol: "TSLA", date: "2014-06-09", fromFactor: 1, toFactor: 7)
        let fixture2 = Split(symbol: "TSLA", date: "2014-06-09", fromFactor: 1, toFactor: 7)
        XCTAssertEqual(fixture1, fixture2)
    }

    func testThatHashable() {
        let fixture1 = Split(symbol: "TSLA", date: "2014-06-09", fromFactor: 1, toFactor: 7)
        let fixture2 = Split(symbol: "AAPL", date: "2014-06-09", fromFactor: 1, toFactor: 7)
        let fixtures: Set<Split> = [fixture1, fixture2]

        XCTAssertTrue(fixtures.contains(fixture1))
        XCTAssertTrue(fixtures.contains(fixture2))
    }
}
