import Foundation

enum FinnhubLiveError: Error {
    case networkFailure(Error)
    case unknownFailure
    case invalidData
}

enum FinnhubLiveSuccess {
    case trades(LiveResponse)
    case news(LiveNews)
    case ping(LivePing)
    case empty
}

final class FinnhubLiveClient {
    static let shared: FinnhubLiveClient = {
        let instance = FinnhubLiveClient()
        return instance
    }()

    fileprivate lazy var socketService: SocketService = {
        SocketService(url: SafeURL.path("wss://ws.finnhub.io?token=\(Constants.API_KEY)"))
    }()

    fileprivate func parseLiveText(_ text: String) -> Result<FinnhubLiveSuccess, FinnhubLiveError> {
        guard let json = text.data(using: .utf8) else {
            return (.failure(.invalidData))
        }
        let decoder = JSONDecoder()
        if let liveTrades = try? decoder.decode(LiveTrades.self, from: json) {
            return (.success(.trades(liveTrades)))
        } else if let marketNews = try? decoder.decode(LiveNews.self, from: json) {
            return (.success(.news(marketNews)))
        } else if let ping = try? decoder.decode(LivePing.self, from: json) {
            return (.success(.ping(ping)))
        } else {
            return (.failure(.invalidData))
        }
    }

    func subscribe(symbol: String) {
        let messageString = "{\"type\":\"subscribe\",\"symbol\":\"\(symbol)\"}"
        socketService.sendMessage(string: messageString)
    }

    func subscribe(symbols: [String]) {
        for symbol in symbols {
            subscribe(symbol: symbol)
        }
    }

    func receiveMessage(completion: @escaping (Result<FinnhubLiveSuccess, FinnhubLiveError>) -> Void) {
        socketService.receiveMessage { [unowned self] result in
            switch result {
            case .connected:
                completion(.success(.empty))
            case .disconnected:
                completion(.success(.empty))
            case let .text(text):
                completion(self.parseLiveText(text))
            case .binary:
                completion(.success(.empty))
            case let .error(error):
                if let unwrappedError = error {
                    completion(.failure(.networkFailure(unwrappedError)))
                } else {
                    completion(.failure(.unknownFailure))
                }

            case .cancelled:
                completion(.success(.empty))
            }
        }
    }

    func closeConnection() {
        socketService.closeConnection()
    }
}
