@testable import FinnhubSwift
import XCTest

final class CompanySymbolQueryTests: XCTestCase {
    func testThatItCreatesCompanySymbolsQuery() {
        let companySymbolsNotJsonString = Data("Hello".utf8)
        let companySymbolsWrong = Data("""
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
        let companySymbolsPartial = Data("""
            {
              "count": 1,
              "result": [
                {
                  "description": "APPLE INC",
                  "symbol": "AAPL",
                  "type": "Common Stock"
                }
              ]
            }
        """.utf8)
        let companySymbol = Data("""
            {
              "count": 1,
              "result": [
                {
                  "description": "APPLE INC",
                  "displaySymbol": "AAPL",
                  "symbol": "AAPL",
                  "type": "Common Stock"
                }
              ]
            }
        """.utf8)
        let companySymbols = Data("""
            {
              "count": 4,
              "result": [
                {
                  "description": "APPLE INC",
                  "displaySymbol": "AAPL",
                  "symbol": "AAPL",
                  "type": "Common Stock"
                },
                {
                  "description": "APPLE INC",
                  "displaySymbol": "AAPL.SW",
                  "symbol": "AAPL.SW",
                  "type": "Common Stock"
                },
                {
                  "description": "APPLE INC",
                  "displaySymbol": "APC.BE",
                  "symbol": "APC.BE",
                  "type": "Common Stock"
                },
                {
                  "description": "APPLE INC",
                  "displaySymbol": "APC.DE",
                  "symbol": "APC.DE",
                  "type": "Common Stock"
                }
              ]
            }
        """.utf8)

        let data: [CodableTester] = [
            CodableTester(payload: companySymbols, expect: true),
            CodableTester(payload: companySymbol, expect: true),
            CodableTester(payload: companySymbolsPartial, expect: false),
            CodableTester(payload: companySymbolsWrong, expect: false),
            CodableTester(payload: companySymbolsNotJsonString, expect: false),
        ]

        for datum in data {
            testThatItCreatesCompanySymbolsQuery(data: datum)
        }
    }

    func testThatItCreatesCompanySymbolsQuery(data: CodableTester) {
        let companySymbol = try? JSONDecoder().decode(CompanySymbolQueryResult.self, from: data.payload)
        if data.expect {
            XCTAssertNotNil(companySymbol)
        } else {
            XCTAssertNil(companySymbol)
        }
    }

    func testThatEquatable() {
        let symbolFixture1 = CompanySymbol(description: "USD", displaySymbol: "PERTH MINT PHYSICAL GOLD ETF", symbol: "AAAU", type: "AAAU", currency: "ETF")
        let fixture1 = CompanySymbolQueryResult(count: 1, result: [symbolFixture1])
        let fixture2 = CompanySymbolQueryResult(count: 1, result: [symbolFixture1])
        XCTAssertEqual(fixture1, fixture2)
    }

    func testThatHashable() {
        let symbolFixture1 = CompanySymbol(description: "USD", displaySymbol: "PERTH MINT PHYSICAL GOLD ETF", symbol: "AAAU", type: "AAAU", currency: "ETF")
        let fixture1 = CompanySymbolQueryResult(count: 1, result: [symbolFixture1])
        let symbolFixture2 = CompanySymbol(description: "USD", displaySymbol: "AGILENT TECHNOLOGIES INC", symbol: "A", type: "A", currency: "EQS")
        let fixture2 = CompanySymbolQueryResult(count: 1, result: [symbolFixture2])
        let fixtures: Set<CompanySymbolQueryResult> = [fixture1, fixture2]

        XCTAssertTrue(fixtures.contains(fixture1))
        XCTAssertTrue(fixtures.contains(fixture2))
    }
}
