@testable import FinnhubSwift
import XCTest

final class FinnhubLiveClientTests: XCTestCase {
    func testThatItParsesInvalidData() {
        let response = """
            àèìòù
        """
        let result = FinnhubLiveClient.shared.parseLiveText(response)

        guard case let .failure(failure) = result else {
            XCTFail("Expected .failure")
            return
        }

        guard case .invalidData = failure else {
            XCTFail("Expected .invalidData")
            return
        }
    }

    func testThatItParsesTrades() {
        let response = """
            {"data":[{"p":7296.89,"s":"BINANCE:BTCUSDT","t":1575526691134,"v":0.011467}],"type":"trade"}
        """
        let result = FinnhubLiveClient.shared.parseLiveText(response)
        let fixture = LiveTrades(data: [Trade(p: 7296.89, s: "BINANCE:BTCUSDT", t: 1_575_526_691_134, v: 0.011467)], type: LiveResponseType.trade.rawValue)
        guard case let .success(success) = result else {
            XCTFail("Expected .success")
            return
        }

        guard case let .trades(trades) = success else {
            XCTFail("Expected .trades")
            return
        }

        XCTAssertEqual(trades, fixture)
    }

    func testThatItParsesPings() {
        let response = """
            {"type":"ping"}
        """
        let result = FinnhubLiveClient.shared.parseLiveText(response)
        let fixture = LivePing(type: LiveResponseType.ping.rawValue)
        guard case let .success(success) = result else {
            XCTFail("Expected .success")
            return
        }

        guard case let .ping(ping) = success else {
            XCTFail("Expected .ping")
            return
        }

        XCTAssertEqual(ping, fixture)
    }

    func testThatItParsesNews() {
        let response = """
            {"data":[{
                "category": "technology",
                "datetime": 1596589501,
                "headline": "Square surges after reporting 64% jump in revenue, more customers using Cash App",
                "id": 5085164,
                "image": "https://image.cnbcfm.com/api/v1/image/105569283-1542050972462rts25mct.jpg?v=1542051069",
                "related": "",
                "source": "CNBC",
                "summary": "Shares of Square soared on Tuesday evening after posting better-than-expected quarterly results and strong growth in its consumer payments app.",
                "url": "https://www.cnbc.com/2020/08/04/square-sq-earnings-q2-2020.html"
            }],"type":"news"}
        """
        let result = FinnhubLiveClient.shared.parseLiveText(response)
        let fixture = LiveNews(data: [MarketNews(category: "technology", datetime: 1_596_589_501, headline: "Square surges after reporting 64% jump in revenue, more customers using Cash App", id: 5_085_164, image: "https://image.cnbcfm.com/api/v1/image/105569283-1542050972462rts25mct.jpg?v=1542051069", related: "", source: "CNBC", url: "https://www.cnbc.com/2020/08/04/square-sq-earnings-q2-2020.html")], type: LiveResponseType.news.rawValue)
        guard case let .success(success) = result else {
            XCTFail("Expected .success")
            return
        }

        guard case let .news(news) = success else {
            XCTFail("Expected .news")
            return
        }

        XCTAssertEqual(news, fixture)
    }
}
