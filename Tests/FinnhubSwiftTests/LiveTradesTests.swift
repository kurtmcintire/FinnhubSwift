@testable import FinnhubSwift
import XCTest

final class LiveTradesTests: XCTestCase {
    func testThatItCreatesTrades() {
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
            {"data":[{"p":7296.89,"t":1575526691134,"v":0.011467}]}
        """.utf8)
        let one = Data("""
            {"data":[{"p":7296.89,"s":"BINANCE:BTCUSDT","t":1575526691134,"v":0.011467}],"type":"trade"}
        """.utf8)

        let data: [CodableTester] = [
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
        let result = try? JSONDecoder().decode(LiveTrades.self, from: data.payload)
        if data.expect {
            print(data)
            XCTAssertNotNil(result)
        } else {
            XCTAssertNil(result)
        }
    }

    func testThatEquatable() {
        let fixture1 = LiveTrades(data: [Trade(p: 7296.89, s: "BINANCE", t: 1_575_526_691_134, v: 0.011467)], type: "trade")
        let fixture2 = LiveTrades(data: [Trade(p: 7296.89, s: "BINANCE", t: 1_575_526_691_134, v: 0.011467)], type: "trade")
        XCTAssertEqual(fixture1, fixture2)
    }

    func testThatHashable() {
        let fixture1 = LiveTrades(data: [Trade(p: 7296.89, s: "BINANCE", t: 1_575_526_691_134, v: 0.011467)], type: "trade")
        let fixture2 = LiveTrades(data: [Trade(p: 7296.89, s: "FOREX", t: 1_575_526_691_134, v: 0.011467)], type: "trade")
        let fixtures: Set<LiveTrades> = [fixture1, fixture2]

        XCTAssertTrue(fixtures.contains(fixture1))
        XCTAssertTrue(fixtures.contains(fixture2))
    }
}
