@testable import FinnhubSwift
import XCTest

final class CovidCaseCountsTests: XCTestCase {
    func testThatItCreatesCovidCaseCounts() {
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
                 "state": "New York",
                 "case": 8403,
               },
             ]
        """.utf8)
        let one = Data("""
             [
               {
                 "state": "New York",
                 "case": 8403,
                 "death": 46,
                 "updated": "2020-03-20 21:38:50"
               },
             ]
        """.utf8)
        let many = Data("""
             [
               {
                 "state": "New York",
                 "case": 8403,
                 "death": 46,
                 "updated": "2020-03-20 21:38:50"
               },
               {
                 "state": "Washington",
                 "case": 1524,
                 "death": 83,
                 "updated": "2020-03-20 21:38:50"
               },
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
            testThatItCreatesCovidCaseCounts(data: datum)
        }
    }

    func testThatItCreatesCovidCaseCounts(data: CodableTester) {
        let country = try? JSONDecoder().decode([CovidCaseCount].self, from: data.payload)
        if data.expect {
            XCTAssertNotNil(country)
        } else {
            XCTAssertNil(country)
        }
    }
}
