@testable import FinnhubSwift
import XCTest

final class PriceTargetTests: XCTestCase {
    func testThatItCreatesPriceTargetEntries() {
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
            {
              "lastUpdated": "2019-06-03 00:00:00",
              "symbol": "NFLX",
              "targetHigh": 500,
              "targetLow": 166,
            }
        """.utf8)
        let intTarget = Data("""
            {
              "lastUpdated": "2019-06-03 00:00:00",
              "symbol": "NFLX",
              "targetHigh": 500,
              "targetLow": 166,
              "targetMean": 387.03,
              "targetMedian": 417.5
            }
        """.utf8)
        let FloatTarget = Data("""
            {
                "lastUpdated":"2020-10-14 00:00:00",
                "symbol":"AAPL",
                "targetHigh":150,
                "targetLow":48.86,
                "targetMean":119.37,
                "targetMedian":125,
            }
        """.utf8)

        let data: [CodableTester] = [
            CodableTester(payload: intTarget, expect: true),
            CodableTester(payload: FloatTarget, expect: true),
            CodableTester(payload: partial, expect: false),
            CodableTester(payload: wrong, expect: false),
            CodableTester(payload: notJsonString, expect: false),
        ]

        for datum in data {
            testThatItCreates(data: datum)
        }
    }

    func testThatItCreates(data: CodableTester) {
        let country = try? JSONDecoder().decode(PriceTarget.self, from: data.payload)
        if data.expect {
            print(data)
            XCTAssertNotNil(country)
        } else {
            XCTAssertNil(country)
        }
    }

    func testThatEquatable() {
        let fixture1 = PriceTarget(lastUpdated: "2019", symbol: "NFLX", targetHigh: 500, targetLow: 166, targetMean: 387.03, targetMedian: 417.5)
        let fixture2 = PriceTarget(lastUpdated: "2019", symbol: "NFLX", targetHigh: 500, targetLow: 166, targetMean: 387.03, targetMedian: 417.5)
        XCTAssertEqual(fixture1, fixture2)
    }

    func testThatHashable() {
        let fixture1 = PriceTarget(lastUpdated: "2019", symbol: "NFLX", targetHigh: 500, targetLow: 166, targetMean: 387.03, targetMedian: 417.5)
        let fixture2 = PriceTarget(lastUpdated: "2018", symbol: "NFLX", targetHigh: 500, targetLow: 166, targetMean: 387.03, targetMedian: 417.5)
        let fixtures: Set<PriceTarget> = [fixture1, fixture2]

        XCTAssertTrue(fixtures.contains(fixture1))
        XCTAssertTrue(fixtures.contains(fixture2))
    }
}
