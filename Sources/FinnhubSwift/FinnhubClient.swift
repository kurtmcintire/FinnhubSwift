import Foundation

public enum FinnhubWebError: Error {
    case networkFailure(Error)
    case invalidData
}

public enum FinnhubClient {
    // MARK: Fileprivate, Static

    fileprivate static func headers() -> (String, String) {
        return (Constants.API_KEY, "X-Finnhub-Token")
    }

    fileprivate static func resourcePayload<A>(url: URL) -> Resource<A> where A: Decodable {
        let resource = Resource<A>(get: url, headers: headers())
        return resource
    }

    static func parseResponse<T>(result: Result<T?, Error>) -> Result<T, FinnhubWebError> {
        switch result {
        case let .success(data):
            if let parsed = data {
                return (.success(parsed))
            } else {
                return (.failure(.invalidData))
            }
        case let .failure(error):
            return (.failure(.networkFailure(error)))
        }
    }

    static func validateDateString(date: String) {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"
        if dateFormatterGet.date(from: date) == nil {
            fatalError("Invalid date string: \(date)")
        }
    }

    // MARK: Company Symbols

    public static func symbols(exchange: Exchange, completion: @escaping (Result<[CompanySymbol], FinnhubWebError>) -> Void) {
        let url = SafeURL.path("\(Constants.BASE_URL)/stock/symbol?exchange=\(exchange.rawValue)")
        let resource = Resource<[CompanySymbol]>(get: url, headers: headers())
        URLSession.shared.load(resource) { (result: Result<[CompanySymbol]?, Error>) in
            completion(FinnhubClient.parseResponse(result: result))
        }
    }

    public static func symbol(query: String, completion: @escaping (Result<CompanySymbolQueryResult, FinnhubWebError>) -> Void) {
        let url = SafeURL.path("\(Constants.BASE_URL)/search?q=\(query)")
        let resource = Resource<CompanySymbolQueryResult>(get: url, headers: headers())
        URLSession.shared.load(resource) { (result: Result<CompanySymbolQueryResult?, Error>) in
            completion(FinnhubClient.parseResponse(result: result))
        }
    }

    // MARK: Market News

    public static func news(category: NewsCategory, completion: @escaping (Result<[MarketNews], FinnhubWebError>) -> Void) {
        newsWithMinId(category: category, minId: 0, completion: { result in
            completion(result)
        })
    }

    public static func newsWithMinId(category: NewsCategory, minId: Int = 0, completion: @escaping (Result<[MarketNews], FinnhubWebError>) -> Void) {
        let url = SafeURL.path("\(Constants.BASE_URL)/news?category=\(category.rawValue)?minId=\(minId)")
        let resource = Resource<[MarketNews]>(get: url, headers: headers())
        URLSession.shared.load(resource) { (result: Result<[MarketNews]?, Error>) in
            completion(FinnhubClient.parseResponse(result: result))
        }
    }

    // MARK: News Sentiment

    public static func newsSentiment(symbol: String, completion: @escaping (Result<NewsSentiment, FinnhubWebError>) -> Void) {
        let url = SafeURL.path("\(Constants.BASE_URL)/news-sentiment?symbol=\(symbol)")
        let resource = Resource<NewsSentiment>(get: url, headers: headers())
        URLSession.shared.load(resource) { (result: Result<NewsSentiment?, Error>) in
            completion(FinnhubClient.parseResponse(result: result))
        }
    }

    // MARK: Peers

    public static func peers(symbol: String, completion: @escaping (Result<[String], FinnhubWebError>) -> Void) {
        let url = SafeURL.path("\(Constants.BASE_URL)/stock/peers?symbol=\(symbol)")
        let resource = Resource<[String]>(get: url, headers: headers())
        URLSession.shared.load(resource) { (result: Result<[String]?, Error>) in
            completion(FinnhubClient.parseResponse(result: result))
        }
    }

    // MARK: Recommendations

    public static func recommendations(symbol: String, completion: @escaping (Result<[Recommendation], FinnhubWebError>) -> Void) {
        let url = SafeURL.path("\(Constants.BASE_URL)/stock/recommendation?symbol=\(symbol)")
        let resource = Resource<[Recommendation]>(get: url, headers: headers())
        URLSession.shared.load(resource) { (result: Result<[Recommendation]?, Error>) in
            completion(FinnhubClient.parseResponse(result: result))
        }
    }

    // MARK: Price Target

    public static func priceTarget(symbol: String, completion: @escaping (Result<PriceTarget, FinnhubWebError>) -> Void) {
        let url = SafeURL.path("\(Constants.BASE_URL)/stock/price-target?symbol=\(symbol)")
        let resource = Resource<PriceTarget>(get: url, headers: headers())
        URLSession.shared.load(resource) { (result: Result<PriceTarget?, Error>) in
            completion(FinnhubClient.parseResponse(result: result))
        }
    }

    // MARK: Company Profile 2

    public static func companyProfile2(symbol: String, completion: @escaping (Result<CompanyProfile, FinnhubWebError>) -> Void) {
        let url = SafeURL.path("\(Constants.BASE_URL)/stock/profile2?symbol=\(symbol)")
        let resource = Resource<CompanyProfile>(get: url, headers: headers())
        URLSession.shared.load(resource) { (result: Result<CompanyProfile?, Error>) in
            completion(FinnhubClient.parseResponse(result: result))
        }
    }

    // MARK: Quote

    public static func quote(symbol: String, completion: @escaping (Result<Quote, FinnhubWebError>) -> Void) {
        let url = SafeURL.path("\(Constants.BASE_URL)/quote?symbol=\(symbol)")
        let resource = Resource<Quote>(get: url, headers: headers())
        URLSession.shared.load(resource) { (result: Result<Quote?, Error>) in
            completion(FinnhubClient.parseResponse(result: result))
        }
    }

    // MARK: Split

    // "to" and "from" parameters should be formatted as YYYY-MM-DD
    public static func split(symbol: String, from: String, to: String, completion: @escaping (Result<[Split], FinnhubWebError>) -> Void) {
        validateDateString(date: from)
        validateDateString(date: to)
        let url = SafeURL.path("\(Constants.BASE_URL)/stock/split?symbol=\(symbol)&from=\(from)&to=\(to)")
        let resource = Resource<[Split]>(get: url, headers: headers())
        URLSession.shared.load(resource) { (result: Result<[Split]?, Error>) in
            completion(FinnhubClient.parseResponse(result: result))
        }
    }

    // MARK: Country

    public static func country(completion: @escaping (Result<[Country], FinnhubWebError>) -> Void) {
        let url = SafeURL.path("\(Constants.BASE_URL)/country")
        let resource = Resource<[Country]>(get: url, headers: headers())
        URLSession.shared.load(resource) { (result: Result<[Country]?, Error>) in
            completion(FinnhubClient.parseResponse(result: result))
        }
    }

    // MARK: Economic Calendar

    public static func economicCalendar(completion: @escaping (Result<EconomicCalendar, FinnhubWebError>) -> Void) {
        let url = SafeURL.path("\(Constants.BASE_URL)/calendar/economic")
        let resource = Resource<EconomicCalendar>(get: url, headers: headers())
        URLSession.shared.load(resource) { (result: Result<EconomicCalendar?, Error>) in
            completion(FinnhubClient.parseResponse(result: result))
        }
    }

    // MARK: FDA Committee Calendar

    public static func fdaAdvisoryCommitteeCalendar(completion: @escaping (Result<[FDACalendarEvent], FinnhubWebError>) -> Void) {
        let url = SafeURL.path("\(Constants.BASE_URL)/fda-advisory-committee-calendar")
        let resource = Resource<[FDACalendarEvent]>(get: url, headers: headers())
        URLSession.shared.load(resource) { (result: Result<[FDACalendarEvent]?, Error>) in
            completion(FinnhubClient.parseResponse(result: result))
        }
    }

    // MARK: Covid Case Count

    public static func covidCasesUS(completion: @escaping (Result<[CovidCaseCount], FinnhubWebError>) -> Void) {
        let url = SafeURL.path("\(Constants.BASE_URL)/covid19/us")
        let resource = Resource<[CovidCaseCount]>(get: url, headers: headers())
        URLSession.shared.load(resource) { (result: Result<[CovidCaseCount]?, Error>) in
            completion(FinnhubClient.parseResponse(result: result))
        }
    }

    // MARK: Aggregate Indicators

    public static func aggregateIndicators(symbol: String, resolution: Resolution, completion: @escaping (Result<AggregateIndicators, FinnhubWebError>) -> Void) {
        let url = SafeURL.path("\(Constants.BASE_URL)/scan/technical-indicator?symbol=\(symbol)&resolution=\(resolution.rawValue)")
        let resource = Resource<AggregateIndicators>(get: url, headers: headers())
        URLSession.shared.load(resource) { (result: Result<AggregateIndicators?, Error>) in
            completion(FinnhubClient.parseResponse(result: result))
        }
    }

    // MARK: Crypto Symbols

    public static func cryptoSymbols(_ exchange: CryptoExchange, completion: @escaping (Result<[CryptoSymbol], FinnhubWebError>) -> Void) {
        let url = SafeURL.path("\(Constants.BASE_URL)/crypto/symbol?exchange=\(exchange.rawValue)")
        let resource = Resource<[CryptoSymbol]>(get: url, headers: headers())
        URLSession.shared.load(resource) { (result: Result<[CryptoSymbol]?, Error>) in
            completion(FinnhubClient.parseResponse(result: result))
        }
    }
}
