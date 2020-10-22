@testable import FinnhubSwift
import XCTest

final class EconomicCalendarTests: XCTestCase {
    func testThatItCreatesEconomicCalendar() {
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
               "economicCalendar": [
                 {
                   "actual": 8.4,
                   "country": "AU",
                   "estimate": 6.9,
                   "event": "Australia - Current Account Balance",
                 },
               ]
             }
        """.utf8)
        let one = Data("""
             {
               "economicCalendar": [
                 {
                   "actual": 8.4,
                   "country": "AU",
                   "estimate": 6.9,
                   "event": "Australia - Current Account Balance",
                   "impact": "low",
                   "prev": 1,
                   "time": "2020-06-02 01:30:00",
                   "unit": "AUD"
                 },
               ]
             }
        """.utf8)
        let many = Data("""
             {
               "economicCalendar": [
                 {
                   "actual": 8.4,
                   "country": "AU",
                   "estimate": 6.9,
                   "event": "Australia - Current Account Balance",
                   "impact": "low",
                   "prev": 1,
                   "time": "2020-06-02 01:30:00",
                   "unit": "AUD"
                 },
                 {
                   "actual": 0.5,
                   "country": "AU",
                   "estimate": 0.4,
                   "event": "Australia- Net Exports",
                   "impact": "low",
                   "prev": -0.1,
                   "time": "2020-06-02 01:30:00",
                   "unit": "%"
                 },
                 {
                    "actual":1900,
                    "country":"CN",
                    "estimate":1700,
                    "event":"China (Mainland)-Money and lending-New Yuan  Loans*",
                    "impact":"low",
                    "prev":1280,
                    "time":"2020-10-12 02:00:00",
                    "unit":"CNY"
                },
                {
                    "actual":null,
                    "country":"US",
                    "estimate":null,
                    "event":"United States-EIA OIL STOCKS-EIA Weekly Gasoline O/P",
                    "impact":"low",
                    "prev":null,
                    "time":"2020-10-21 14:30:00",
                    "unit":"Barrel/Day"
                },
               ]
             }
        """.utf8)

        let data: [CodableTester] = [
            CodableTester(payload: many, expect: true),
            CodableTester(payload: one, expect: true),
            CodableTester(payload: partial, expect: false),
            CodableTester(payload: wrong, expect: false),
            CodableTester(payload: notJsonString, expect: false),
        ]

        for datum in data {
            testThatItCreatesEconomicCalendar(data: datum)
        }
    }

    func testThatItCreatesEconomicCalendar(data: CodableTester) {
        let country = try? JSONDecoder().decode(EconomicCalendar.self, from: data.payload)
        if data.expect {
            XCTAssertNotNil(country)
        } else {
            XCTAssertNil(country)
        }
    }

    func testThatEquatable() {
        let fixture1 = EconomicCalendar(economicCalendar: [EconomicEvent(actual: 0.5, country: "AU", estimate: 0.4, event: "Australia-NetExports", impact: "low", prev: -0.1, time: "2020-06-02", unit: "%")])
        let fixture2 = EconomicCalendar(economicCalendar: [EconomicEvent(actual: 0.5, country: "AU", estimate: 0.4, event: "Australia-NetExports", impact: "low", prev: -0.1, time: "2020-06-02", unit: "%")])
        XCTAssertEqual(fixture1, fixture2)
    }

    func testThatHashable() {
        let fixture1 = EconomicCalendar(economicCalendar: [EconomicEvent(actual: 0.5, country: "AU", estimate: 0.4, event: "Australia-NetExports", impact: "low", prev: -0.1, time: "2020-06-02", unit: "%")])
        let fixture2 = EconomicCalendar(economicCalendar: [EconomicEvent(country: "US", event: "United States-EIA OIL STOCKS-EIA Weekly Gasoline O/P", impact: "low", time: "2020-06-02", unit: "Barrel/Day")])
        let fixtures: Set<EconomicCalendar> = [fixture1, fixture2]

        XCTAssertTrue(fixtures.contains(fixture1))
        XCTAssertTrue(fixtures.contains(fixture2))
    }
}
