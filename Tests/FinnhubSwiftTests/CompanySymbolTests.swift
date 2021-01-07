@testable import FinnhubSwift
import XCTest

final class CompanySymbolTests: XCTestCase {
    func testThatItCreatesCompanySymbols() {
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
             [
               {
                 "description": "AGILENT TECHNOLOGIES INC",
                 "displaySymbol": "A",
                 "symbol": "A",
               },
               {
                 "description": "ALCOA CORP",
                 "type": "EQS",
                 "currency": "USD"
               },
               {
                 "description": "PERTH MINT PHYSICAL GOLD ETF",
                 "displaySymbol": "AAAU",
                 "currency": "USD"
               }
             ]
        """.utf8)
        let companySymbol = Data("""
             [
               {
                 "description": "AGILENT TECHNOLOGIES INC",
                 "displaySymbol": "A",
                 "symbol": "A",
                 "type": "EQS",
                 "currency": "USD"
               }
             ]
        """.utf8)
        let companySymbols = Data("""
             [
               {
                 "description": "AGILENT TECHNOLOGIES INC",
                 "displaySymbol": "A",
                 "symbol": "A",
                 "type": "EQS",
                 "currency": "USD"
               },
               {
                 "description": "ALCOA CORP",
                 "displaySymbol": "AA",
                 "symbol": "AA",
                 "type": "EQS",
                 "currency": "USD"
               },
               {
                 "description": "PERTH MINT PHYSICAL GOLD ETF",
                 "displaySymbol": "AAAU",
                 "symbol": "AAAU",
                 "type": "ETF",
                 "currency": "USD"
               }
             ]
        """.utf8)

        let data: [CodableTester] = [
            CodableTester(payload: companySymbols, expect: true),
            CodableTester(payload: companySymbol, expect: true),
            CodableTester(payload: companySymbolsPartial, expect: false),
            CodableTester(payload: companySymbolsWrong, expect: false),
            CodableTester(payload: companySymbolsNotJsonString, expect: false),
        ]

        for datum in data {
            testThatItCreatesCompanySymbols(data: datum)
        }
    }

    func testThatItCreatesCompanySymbols(data: CodableTester) {
        let companySymbol = try? JSONDecoder().decode([CompanySymbol].self, from: data.payload)
        if data.expect {
            XCTAssertNotNil(companySymbol)
        } else {
            XCTAssertNil(companySymbol)
        }
    }

    func testThatEquatable() {
        let fixture1 = CompanySymbol(description: "USD", displaySymbol: "PERTH MINT PHYSICAL GOLD ETF", symbol: "AAAU", type: "AAAU", currency: "ETF")
        let fixture2 = CompanySymbol(description: "USD", displaySymbol: "PERTH MINT PHYSICAL GOLD ETF", symbol: "AAAU", type: "AAAU", currency: "ETF")
        XCTAssertEqual(fixture1, fixture2)
    }

    func testThatHashable() {
        let fixture1 = CompanySymbol(description: "USD", displaySymbol: "PERTH MINT PHYSICAL GOLD ETF", symbol: "AAAU", type: "AAAU", currency: "ETF")
        let fixture2 = CompanySymbol(description: "USD", displaySymbol: "AGILENT TECHNOLOGIES INC", symbol: "A", type: "A", currency: "EQS")
        let fixtures: Set<CompanySymbol> = [fixture1, fixture2]

        XCTAssertTrue(fixtures.contains(fixture1))
        XCTAssertTrue(fixtures.contains(fixture2))
    }
}
