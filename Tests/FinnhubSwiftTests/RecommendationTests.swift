@testable import FinnhubSwift
import XCTest

final class RecommendationTests: XCTestCase {
    func testThatItCreatesRecommendations() {
        let notJsonString = Data("Hello".utf8)
        let wrong = Data("""
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
            [
              {
                "buy": 17,
                "hold": 13,
                "period": "2020-02-01",
              }
            ]
        """.utf8)
        let one = Data("""
            [
              {
                "buy": 17,
                "hold": 13,
                "period": "2020-02-01",
                "sell": 5,
                "strongBuy": 13,
                "strongSell": 0,
                "symbol": "AAPL"
              }
            ]
        """.utf8)
        let many = Data("""
            [
              {
                "buy": 24,
                "hold": 7,
                "period": "2020-03-01",
                "sell": 0,
                "strongBuy": 13,
                "strongSell": 0,
                "symbol": "AAPL"
              },
              {
                "buy": 17,
                "hold": 13,
                "period": "2020-02-01",
                "sell": 5,
                "strongBuy": 13,
                "strongSell": 0,
                "symbol": "AAPL"
              }
            ]
        """.utf8)

        let data: [CodableTester] = [
            CodableTester(payload: many, expect: true),
            CodableTester(payload: one, expect: true),
            CodableTester(payload: partial, expect: false),
            CodableTester(payload: wrong, expect: false),
            CodableTester(payload: notJsonString, expect: false),
        ]

        for datum in data {
            testThatItCreates(data: datum)
        }
    }

    func testThatItCreates(data: CodableTester) {
        let result = try? JSONDecoder().decode([Recommendation].self, from: data.payload)
        if data.expect {
            print(data)
            XCTAssertNotNil(result)
        } else {
            XCTAssertNil(result)
        }
    }

    func testThatEquatable() {
        let fixture1 = Recommendation(buy: 17, hold: 13, period: "2020-02-01", sell: 5, strongBuy: 13, strongSell: 0, symbol: "AAPL")
        let fixture2 = Recommendation(buy: 17, hold: 13, period: "2020-02-01", sell: 5, strongBuy: 13, strongSell: 0, symbol: "AAPL")
        XCTAssertEqual(fixture1, fixture2)
    }

    func testThatHashable() {
        let fixture1 = Recommendation(buy: 17, hold: 13, period: "2020-02-01", sell: 5, strongBuy: 13, strongSell: 0, symbol: "AAPL")
        let fixture2 = Recommendation(buy: 17, hold: 13, period: "2020-02-01", sell: 5, strongBuy: 14, strongSell: 0, symbol: "NTFL")
        let fixtures: Set<Recommendation> = [fixture1, fixture2]

        XCTAssertTrue(fixtures.contains(fixture1))
        XCTAssertTrue(fixtures.contains(fixture2))
    }
}
