@testable import FinnhubSwift
import XCTest

final class LivePingTests: XCTestCase {
    func testThatItCreatesLivePing() {
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
            {"typo":"ping"}
        """.utf8)
        let one = Data("""
            {"type":"ping"}
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
        let result = try? JSONDecoder().decode(LivePing.self, from: data.payload)
        if data.expect {
            print(data)
            XCTAssertNotNil(result)
        } else {
            XCTAssertNil(result)
        }
    }

    func testThatEquatable() {
        let fixture1 = LivePing(type: "ping")
        let fixture2 = LivePing(type: "ping")
        XCTAssertEqual(fixture1, fixture2)
    }

    func testThatHashable() {
        let fixture1 = LivePing(type: "ping")
        let fixture2 = LivePing(type: "pong")
        let fixtures: Set<LivePing> = [fixture1, fixture2]

        XCTAssertTrue(fixtures.contains(fixture1))
        XCTAssertTrue(fixtures.contains(fixture2))
    }
}
