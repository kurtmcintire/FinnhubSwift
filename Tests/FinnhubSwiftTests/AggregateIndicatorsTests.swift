@testable import FinnhubSwift
import XCTest

final class AggregateIndicatorsTests: XCTestCase {
    func testThatItCreatesAggregateIndicators() {
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
                 "technicalAnalysis":{
                     "count":{
                         "buy":7,
                         "neutral":8,
                         "sell":2
                     },
                     "signal":"buy"
                 },
             }
        """.utf8)
        let one = Data("""
             {
                 "technicalAnalysis":{
                     "count":{
                         "buy":7,
                         "neutral":8,
                         "sell":2
                     },
                     "signal":"buy"
                 },
                 "trend":{
                     "adx":20.172131665096146,
                     "trending":false
                 }
             }
        """.utf8)

        let data: [CodableTester] = [
            CodableTester(payload: one, expect: true),
            CodableTester(payload: partial, expect: false),
            CodableTester(payload: wrong, expect: false),
            CodableTester(payload: notJsonString, expect: false),
        ]

        for datum in data {
            testThatItCreatesAggregateIndicator(data: datum)
        }
    }

    func testThatItCreatesAggregateIndicator(data: CodableTester) {
        let fixture = try? JSONDecoder().decode(AggregateIndicators.self, from: data.payload)
        if data.expect {
            XCTAssertNotNil(fixture)
        } else {
            XCTAssertNil(fixture)
        }
    }

    func testThatEquatable() {
        let fixture1 = AggregateIndicators(technicalAnalysis: TechnicalAnalysis(count: TechnicalAnalysisCount(buy: 7, neutral: 8, sell: 2), signal: "buy"), trend: Trend(adx: 20.17213665096146, trending: false))
        let fixture2 = AggregateIndicators(technicalAnalysis: TechnicalAnalysis(count: TechnicalAnalysisCount(buy: 7, neutral: 8, sell: 2), signal: "buy"), trend: Trend(adx: 20.17213665096146, trending: false))
        XCTAssertEqual(fixture1, fixture2)
    }

    func testThatHashable() {
        let fixture1 = AggregateIndicators(technicalAnalysis: TechnicalAnalysis(count: TechnicalAnalysisCount(buy: 7, neutral: 8, sell: 2), signal: "buy"), trend: Trend(adx: 20.17213665096146, trending: false))
        let fixture2 = AggregateIndicators(technicalAnalysis: TechnicalAnalysis(count: TechnicalAnalysisCount(buy: 7, neutral: 8, sell: 2), signal: "sell"), trend: Trend(adx: 10.17213665096146, trending: false))
        let fixtures: Set<AggregateIndicators> = [fixture1, fixture2]

        XCTAssertTrue(fixtures.contains(fixture1))
        XCTAssertTrue(fixtures.contains(fixture2))
    }
}
