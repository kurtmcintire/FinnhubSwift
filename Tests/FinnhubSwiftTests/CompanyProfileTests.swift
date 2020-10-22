@testable import FinnhubSwift
import XCTest

final class CompanyProfileTests: XCTestCase {
    func testThatItCreatesCompanyProfiles() {
        let companyNotJsonString = Data("Hello".utf8)
        let companyWrong = Data("""
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
        let companyPartial = Data("""
            {
              "country": "US",
              "currency": "USD",
              "exchange": "NASDAQ/NMS (GLOBAL MARKET)",
              "ipo": "1980-12-12",
              "marketCapitalization": 1415993,
              "name": "Apple Inc",
            }
        """.utf8)
        let companyDocumentation = Data("""
            {
              "country": "US",
              "currency": "USD",
              "exchange": "NASDAQ/NMS (GLOBAL MARKET)",
              "ipo": "1980-12-12",
              "marketCapitalization": 1415993,
              "name": "Apple Inc",
              "phone": "14089961010",
              "shareOutstanding": 4375.47998046875,
              "ticker": "AAPL",
              "weburl": "https://www.apple.com/",
              "logo": "https://static.finnhub.io/logo/87cb30d8-80df-11ea-8951-00000000092a.png",
              "finnhubIndustry":"Technology"
            }
        """.utf8)

        let data: [CodableTester] = [
            CodableTester(payload: companyDocumentation, expect: true),
            CodableTester(payload: companyPartial, expect: false),
            CodableTester(payload: companyWrong, expect: false),
            CodableTester(payload: companyNotJsonString, expect: false),
        ]

        for datum in data {
            testThatItCreatesCompanyProfile(data: datum)
        }
    }

    func testThatItCreatesCompanyProfile(data: CodableTester) {
        let companyProfile = try? JSONDecoder().decode(CompanyProfile.self, from: data.payload)
        if data.expect {
            XCTAssertNotNil(companyProfile)
        } else {
            XCTAssertNil(companyProfile)
        }
    }

    func testThatEquatable() {
        let fixture1 = CompanyProfile(country: "US", currency: "USD", exchange: "NASDAQ", ipo: "1980", marketCapitalization: 1_415_993, name: "Apple Inc", phone: "1409961010", shareOutstanding: 4375.47998, ticker: "AAPL", weburl: "https://www.apple.com", logo: "https://static.finnhub.io/logo/87cb30d8-80df-11ea-8951-00000000092a.png", finnhubIndustry: "Technology")
        let fixture2 = CompanyProfile(country: "US", currency: "USD", exchange: "NASDAQ", ipo: "1980", marketCapitalization: 1_415_993, name: "Apple Inc", phone: "1409961010", shareOutstanding: 4375.47998, ticker: "AAPL", weburl: "https://www.apple.com", logo: "https://static.finnhub.io/logo/87cb30d8-80df-11ea-8951-00000000092a.png", finnhubIndustry: "Technology")
        XCTAssertEqual(fixture1, fixture2)
    }

    func testThatHashable() {
        let fixture1 = CompanyProfile(country: "US", currency: "USD", exchange: "NASDAQ", ipo: "1980", marketCapitalization: 1_415_993, name: "Apple Inc", phone: "1409961010", shareOutstanding: 4375.47998, ticker: "AAPL", weburl: "https://www.apple.com", logo: "https://static.finnhub.io/logo/87cb30d8-80df-11ea-8951-00000000092a.png", finnhubIndustry: "Technology")
        let fixture2 = CompanyProfile(country: "US", currency: "USD", exchange: "NASDAQ", ipo: "1980", marketCapitalization: 1_415_993, name: "Slack, Inc.", phone: "1409961010", shareOutstanding: 4375.47998, ticker: "WORK", weburl: "https://www.slack.com", logo: "https://static.finnhub.io/logo/87cb30d8-80df-11ea-8951-00000000092a.png", finnhubIndustry: "Technology")
        let fixtures: Set<CompanyProfile> = [fixture1, fixture2]

        XCTAssertTrue(fixtures.contains(fixture1))
        XCTAssertTrue(fixtures.contains(fixture2))
    }
}
