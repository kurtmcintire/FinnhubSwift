import Foundation

enum FinnhubWebError: Error {
    case networkFailure(Error)
    case invalidData
}

struct FinnhubClient {
    // MARK: Fileprivate, Static

    fileprivate static func headers() -> (String, String) {
        return (Constants.API_KEY, "X-Finnhub-Token")
    }

    fileprivate static func resourcePayload<A>(url: URL) -> Resource<A> where A: Decodable {
        let resource = Resource<A>(get: url, headers: headers())
        return resource
    }

    fileprivate static func parseResponse<T>(result: Result<T?, Error>) -> Result<T?, FinnhubWebError> {
        switch result {
        case let .success(data):
            if let symbols = data {
                return (.success(symbols))
            } else {
                return (.failure(.invalidData))
            }
        case let .failure(error):
            return (.failure(.networkFailure(error)))
        }
    }

    // MARK: Symbols

    static func symbols(exchange: Exchange, completion: @escaping (Result<[CompanySymbol]?, FinnhubWebError>) -> Void) {
        let url = SafeURL.path("\(Constants.BASE_URL)/stock/symbol?exchange=\(exchange.rawValue)")
        let resource = Resource<[CompanySymbol]>(get: url, headers: headers())
        URLSession.shared.load(resource) { (result: Result<[CompanySymbol]?, Error>) in
            completion(FinnhubClient.parseResponse(result: result))
        }
    }

    // MARK: Market News

    static func news(category: NewsCategory, completion: @escaping (Result<[MarketNews]?, FinnhubWebError>) -> Void) {
        newsWithMinId(category: category, minId: 0, completion: { result in
            completion(result)
        })
    }

    static func newsWithMinId(category: NewsCategory, minId: Int = 0, completion: @escaping (Result<[MarketNews]?, FinnhubWebError>) -> Void) {
        let url = SafeURL.path("\(Constants.BASE_URL)/news?category=\(category.rawValue)?minId=\(minId)")
        let resource = Resource<[MarketNews]>(get: url, headers: headers())
        URLSession.shared.load(resource) { (result: Result<[MarketNews]?, Error>) in
            completion(FinnhubClient.parseResponse(result: result))
        }
    }

    // MARK: News Sentiment

    static func newsSentiment(symbol: String, completion: @escaping (Result<NewsSentiment?, FinnhubWebError>) -> Void) {
        let url = SafeURL.path("\(Constants.BASE_URL)/news-sentiment?symbol=\(symbol)")
        let resource = Resource<NewsSentiment>(get: url, headers: headers())
        URLSession.shared.load(resource) { (result: Result<NewsSentiment?, Error>) in
            completion(FinnhubClient.parseResponse(result: result))
        }
    }

    // MARK: Peers

    static func peers(symbol: String, completion: @escaping (Result<[String]?, FinnhubWebError>) -> Void) {
        let url = SafeURL.path("\(Constants.BASE_URL)/stock/peers?symbol=\(symbol)")
        let resource = Resource<[String]>(get: url, headers: headers())
        URLSession.shared.load(resource) { (result: Result<[String]?, Error>) in
            completion(FinnhubClient.parseResponse(result: result))
        }
    }

    // MARK: Recommendations

    static func recommendations(symbol: String, completion: @escaping (Result<[Recommendation]?, FinnhubWebError>) -> Void) {
        let url = SafeURL.path("\(Constants.BASE_URL)/stock/recommendation?symbol=\(symbol)")
        let resource = Resource<[Recommendation]>(get: url, headers: headers())
        URLSession.shared.load(resource) { (result: Result<[Recommendation]?, Error>) in
            completion(FinnhubClient.parseResponse(result: result))
        }
    }

    // MARK: Price Target

    static func priceTarget(symbol: String, completion: @escaping (Result<PriceTarget?, FinnhubWebError>) -> Void) {
        let url = SafeURL.path("\(Constants.BASE_URL)/stock/price-target?symbol=\(symbol)")
        let resource = Resource<PriceTarget>(get: url, headers: headers())
        URLSession.shared.load(resource) { (result: Result<PriceTarget?, Error>) in
            completion(FinnhubClient.parseResponse(result: result))
        }
    }

    // MARK: Company Profile 2

    static func companyProfile2(symbol: String, completion: @escaping (Result<CompanyProfile?, FinnhubWebError>) -> Void) {
        let url = SafeURL.path("\(Constants.BASE_URL)/stock/profile2?symbol=\(symbol)")
        let resource = Resource<CompanyProfile>(get: url, headers: headers())
        URLSession.shared.load(resource) { (result: Result<CompanyProfile?, Error>) in
            completion(FinnhubClient.parseResponse(result: result))
        }
    }
}
