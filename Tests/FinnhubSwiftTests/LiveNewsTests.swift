@testable import FinnhubSwift
import XCTest

final class LiveNewsTests: XCTestCase {
    func testThatItCreatesLiveNews() {
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
                "data":
                    [
                      {
                        "category": "technology",
                        "datetime": 1596589501,
                        "headline": "Square surges after reporting 64% jump in revenue, more customers using Cash App",
                        "id": 5085164,
                        "image": "https://image.cnbcfm.com/api/v1/image/105569283-1542050972462rts25mct.jpg?v=1542051069",
                      }
                    ],
            }
        """.utf8)
        let one = Data("""
            {
                "data":
                    [
                      {
                        "category": "technology",
                        "datetime": 1596589501,
                        "headline": "Square surges after reporting 64% jump in revenue, more customers using Cash App",
                        "id": 5085164,
                        "image": "https://image.cnbcfm.com/api/v1/image/105569283-1542050972462rts25mct.jpg?v=1542051069",
                        "related": "",
                        "source": "CNBC",
                        "url": "https://www.cnbc.com/2020/08/04/square-sq-earnings-q2-2020.html"
                      }
                    ],
                "type":"trade"
            }
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
        let result = try? JSONDecoder().decode(LiveNews.self, from: data.payload)
        if data.expect {
            print(data)
            XCTAssertNotNil(result)
        } else {
            XCTAssertNil(result)
        }
    }

    func testThatEquatable() {
        let fixture1 = LiveNews(data: [MarketNews(category: "technology", datetime: 156_934_523_432, headline: "B&G Foods", id: 5_085_113, image: "https://image.com", related: "", source: "CNBC", url: "https://cnbc.com")], type: "news")
        let fixture2 = LiveNews(data: [MarketNews(category: "technology", datetime: 156_934_523_432, headline: "B&G Foods", id: 5_085_113, image: "https://image.com", related: "", source: "CNBC", url: "https://cnbc.com")], type: "news")
        XCTAssertEqual(fixture1, fixture2)
    }

    func testThatHashable() {
        let fixture1 = LiveNews(data: [MarketNews(category: "technology", datetime: 156_934_523_432, headline: "B&G Foods", id: 5_085_112, image: "https://image.com", related: "", source: "CNBC", url: "https://cnbc.com")], type: "news")
        let fixture2 = LiveNews(data: [MarketNews(category: "technology", datetime: 156_934_523_432, headline: "B&G Foods", id: 5_085_113, image: "https://image.com", related: "", source: "CNBC", url: "https://cnbc.com")], type: "news")
        let fixtures: Set<LiveNews> = [fixture1, fixture2]

        XCTAssertTrue(fixtures.contains(fixture1))
        XCTAssertTrue(fixtures.contains(fixture2))
    }
}
