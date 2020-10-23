@testable import FinnhubSwift
import XCTest

final class MarketNewsTests: XCTestCase {
    func testsThatItCreatesMarketNewsEntries() {
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
                "category": "technology",
                "datetime": 1596589501,

                "image": "https://image.cnbcfm.com/api/v1/image/105569283-1542050972462rts25mct.jpg?v=1542051069",
              }
            ]
        """.utf8)
        let one = Data("""
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
            ]
        """.utf8)
        let many = Data("""
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
              },
            {
                "category": "business",
                "datetime": 1596588232,
                "headline": "B&G Foods CEO expects pantry demand to hold up post-pandemic",
                "id": 5085113,
                "image": "https://image.cnbcfm.com/api/v1/image/106629991-1595532157669-gettyimages-1221952946-362857076_1-5.jpeg?v=1595532242",
                "related": "",
                "source": "CNBC",
                "url": "https://www.cnbc.com/2020/08/04/bg-foods-ceo-expects-pantry-demand-to-hold-up-post-pandemic.html"
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
            testsThatItCreatesMarketNews(data: datum)
        }
    }

    func testsThatItCreatesMarketNews(data: CodableTester) {
        let country = try? JSONDecoder().decode([MarketNews].self, from: data.payload)
        if data.expect {
            print(data)
            XCTAssertNotNil(country)
        } else {
            XCTAssertNil(country)
        }
    }

    func testThatEquatable() {
        let fixture1 = MarketNews(category: "technology", datetime: 156_934_523_432, headline: "B&G Foods", id: 5_085_113, image: "https://image.com", related: "", source: "CNBC", url: "https://cnbc.com")
        let fixture2 = MarketNews(category: "technology", datetime: 156_934_523_432, headline: "B&G Foods", id: 5_085_113, image: "https://image.com", related: "", source: "CNBC", url: "https://cnbc.com")
        XCTAssertEqual(fixture1, fixture2)
    }

    func testThatEquatableById() {
        let fixture1 = MarketNews(category: "technology", datetime: 156_934_523_432, headline: "B&G Foods", id: 5_085_113, image: "https://image.com", related: "", source: "CNBC", url: "https://cnbc.com")
        let fixture2 = MarketNews(category: "news", datetime: 2, headline: "", id: 5_085_113, image: "https://image.com", related: "", source: "CNBC", url: "https://cnbc.com")
        XCTAssertEqual(fixture1, fixture2)
    }

    func testThatHashable() {
        let fixture1 = MarketNews(category: "technology", datetime: 156_934_523_432, headline: "B&G Foods", id: 5_085_113, image: "https://image.com", related: "", source: "CNBC", url: "https://cnbc.com")
        let fixture2 = MarketNews(category: "news", datetime: 2, headline: "", id: 5_085_111, image: "https://image.com", related: "", source: "CNBC", url: "https://cnbc.com")
        let fixtures: Set<MarketNews> = [fixture1, fixture2]

        XCTAssertTrue(fixtures.contains(fixture1))
        XCTAssertTrue(fixtures.contains(fixture2))
    }
}
