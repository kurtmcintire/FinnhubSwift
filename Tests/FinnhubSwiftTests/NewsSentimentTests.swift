@testable import FinnhubSwift
import XCTest

final class NewsSentimentTests: XCTestCase {
    func testsThatItCreatesNewsEntries() {
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
              "buzz": {
                "articlesInLastWeek": 20,
                "buzz": 0.8888,
                "weeklyAverage": 22.5
              },
              "companyNewsScore": 0.9166,
              "sectorAverageBullishPercent": 0.6482,
              "symbol": "V"
            }
        """.utf8)
        let one = Data("""
            {
              "buzz": {
                "articlesInLastWeek": 20,
                "buzz": 0.8888,
                "weeklyAverage": 22.5
              },
              "companyNewsScore": 0.9166,
              "sectorAverageBullishPercent": 0.6482,
              "sectorAverageNewsScore": 0.5191,
              "sentiment": {
                "bearishPercent": 0,
                "bullishPercent": 1
              },
              "symbol": "V"
            }
        """.utf8)

        let data: [CodableTester] = [
            CodableTester(payload: one, expect: true),
            CodableTester(payload: partial, expect: false),
            CodableTester(payload: wrong, expect: false),
            CodableTester(payload: notJsonString, expect: false),
        ]

        for datum in data {
            testsThatItCreatesNews(data: datum)
        }
    }

    func testsThatItCreatesNews(data: CodableTester) {
        let country = try? JSONDecoder().decode(NewsSentiment.self, from: data.payload)
        if data.expect {
            print(data)
            XCTAssertNotNil(country)
        } else {
            XCTAssertNil(country)
        }
    }

    func testThatEquatable() {
        let fixture1 = NewsSentiment(buzz: Buzz(articlesInLastWeek: 20, buzz: 0.888, weeklyAverage: 22.5), companyNewsScore: 0.9166, sectorAverageBullishPercent: 0.6482, sectorAverageNewsScore: 0.5191, sentiment: Sentiment(bearishPercent: 0, bullishPercent: 1), symbol: "V")
        let fixture2 = NewsSentiment(buzz: Buzz(articlesInLastWeek: 20, buzz: 0.888, weeklyAverage: 22.5), companyNewsScore: 0.9166, sectorAverageBullishPercent: 0.6482, sectorAverageNewsScore: 0.5191, sentiment: Sentiment(bearishPercent: 0, bullishPercent: 1), symbol: "V")
        XCTAssertEqual(fixture1, fixture2)
    }

    func testThatHashable() {
        let fixture1 = NewsSentiment(buzz: Buzz(articlesInLastWeek: 20, buzz: 0.888, weeklyAverage: 22.5), companyNewsScore: 0.9166, sectorAverageBullishPercent: 0.6482, sectorAverageNewsScore: 0.5191, sentiment: Sentiment(bearishPercent: 0, bullishPercent: 1), symbol: "V")
        let fixture2 = NewsSentiment(buzz: Buzz(articlesInLastWeek: 20, buzz: 0.887, weeklyAverage: 22.5), companyNewsScore: 0.9166, sectorAverageBullishPercent: 0.6482, sectorAverageNewsScore: 0.5191, sentiment: Sentiment(bearishPercent: 0, bullishPercent: 1), symbol: "V")
        let fixtures: Set<NewsSentiment> = [fixture1, fixture2]

        XCTAssertTrue(fixtures.contains(fixture1))
        XCTAssertTrue(fixtures.contains(fixture2))
    }
}
