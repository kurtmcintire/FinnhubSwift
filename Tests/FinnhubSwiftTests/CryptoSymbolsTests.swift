@testable import FinnhubSwift
import XCTest

final class CryptoSymbolsTests: XCTestCase {
    func testsThatItCreatesCryptoSymbols() {
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
                "description": "Binance BNBBTC",
                "displaySymbol": "BNB/BTC",
              }
            ]
        """.utf8)
        let one = Data("""
            [
              {
                "description": "Binance BNBBTC",
                "displaySymbol": "BNB/BTC",
                "symbol": "BINANCE:BNBBTC"
              }
            ]
        """.utf8)
        let many = Data("""
            [
              {
                "description": "Binance ETHBTC",
                "displaySymbol": "ETH/BTC",
                "symbol": "ETHBTC"
              },
              {
                "description": "Binance LTCBTC",
                "displaySymbol": "LTC/BTC",
                "symbol": "BINANCE:LTCBTC"
              },
              {
                "description": "Binance BNBBTC",
                "displaySymbol": "BNB/BTC",
                "symbol": "BINANCE:BNBBTC"
              }]
        """.utf8)

        let data: [CodableTester] = [
            CodableTester(payload: many, expect: true),
            CodableTester(payload: one, expect: true),
            CodableTester(payload: partial, expect: false),
            CodableTester(payload: wrong, expect: false),
            CodableTester(payload: notJsonString, expect: false),
        ]

        for datum in data {
            testsThatItCreatesCryptoSymbols(data: datum)
        }
    }

    func testsThatItCreatesCryptoSymbols(data: CodableTester) {
        let country = try? JSONDecoder().decode([CryptoSymbol].self, from: data.payload)
        if data.expect {
            XCTAssertNotNil(country)
        } else {
            XCTAssertNil(country)
        }
    }

    func testThatEquatable() {
        let fixture1 = CryptoSymbol(description: "Binance ETHBTC", displaySymbol: "ETH/BTC", symbol: "ETHBTC")
        let fixture2 = CryptoSymbol(description: "Binance ETHBTC", displaySymbol: "ETH/BTC", symbol: "ETHBTC")
        XCTAssertEqual(fixture1, fixture2)
    }

    func testThatHashable() {
        let fixture1 = CryptoSymbol(description: "Binance ETHBTC", displaySymbol: "ETH/BTC", symbol: "ETHBTC")
        let fixture2 = CryptoSymbol(description: "Binance ETHBTC", displaySymbol: "ETH/BTC", symbol: "ETHBTC")
        let fixtures: Set<CryptoSymbol> = [fixture1, fixture2]

        XCTAssertTrue(fixtures.contains(fixture1))
        XCTAssertTrue(fixtures.contains(fixture2))
    }
}
