import FinnhubSwift
import Foundation

class SymbolDetailViewModel {
    var title: String { return symbol }
    var name: String? { return data?.name }
    var logo: String? { return data?.logo }
    var priceString: String? {
        price != nil ? "$\(String(format: "%.2f", price!))" : ""
    }

    private var symbol: String
    private var data: CompanyProfile?

    @Published var loading: Bool = false
    @Published var stats: [String: String]?
    @Published var price: Float?

    init(symbol: String) {
        self.symbol = symbol
    }

    func streamPrice() {
        FinnhubLiveClient.shared.subscribe(symbol: symbol)
        FinnhubLiveClient.shared.receiveMessage { [weak self] result in
            switch result {
            case let .success(success):
                switch success {
                case let .trades(trades):
                    self?.price = trades.data[0].p
                case let .news(news):
                    print(news) // Prints a LiveNews object
                case let .ping(ping):
                    print(ping) // Prints a Ping object
                case .empty:
                    print("Empty data")
                }
            case let .failure(failure):
                switch failure {
                case .networkFailure:
                    print(failure)
                case .invalidData:
                    print("Invalid data")
                case .unknownFailure:
                    print("Unknown failure")
                }
            }
        }
    }

    func fetchSymbol() {
        loading = true
        let group = DispatchGroup()
        group.enter()
        FinnhubClient.companyProfile2(symbol: symbol) { [weak self] result in
            group.leave()
            switch result {
            case let .success(data):
                self?.data = data
                self?.stats = [
                    "Country": data.country,
                    "Mkt Cap": String(data.marketCapitalization),
                    "Shares": String(data.shareOutstanding),
                    "Industry": data.finnhubIndustry,
                ]
            case .failure(.invalidData):
                self?.data = nil
                self?.stats = nil
            case .failure(.networkFailure(_)):
                self?.data = nil
                self?.stats = nil
            }
        }

        group.enter()
        FinnhubClient.quote(symbol: symbol, completion: { [weak self] result in
            group.leave()
            switch result {
            case let .success(quote):
                self?.price = quote.current
            case .failure(.invalidData):
                self?.price = nil
            case .failure(.networkFailure(_)):
                self?.price = nil
            }
        })

        group.notify(queue: .global()) { [weak self] in
            self?.loading = false
        }
    }
}
