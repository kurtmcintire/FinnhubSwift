import FinnhubSwift
import UIKit

class ViewController: UIViewController {
    var isConnected: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackground()
        loadData()
    }

    func setupBackground() {
        view.backgroundColor = .white
    }

    func loadData() {
        /*
          FinnhubClient.symbols(exchange: .unitedStates) { result in
              switch result {
              case let .success(data):
                  print(data)
              case .failure(.invalidData):
                  print("Invalid data")
              case let .failure(.networkFailure(error)):
                  print(error)
              }
          }

          FinnhubClient.news(category: .general) { result in
              switch result {
              case let .success(data):
                  print(data)
              case .failure(.invalidData):
                  print("Invalid data")
              case let .failure(.networkFailure(error)):
                  print(error)
              }
          }

          FinnhubClient.peers(symbol: "AAPL") { result in
              switch result {
              case let .success(data):
                  print(data)
              case .failure(.invalidData):
                  print("Invalid data")
              case let .failure(.networkFailure(error)):
                  print(error)
              }
          }

          FinnhubClient.newsSentiment(symbol: "AAPL") { result in
              switch result {
              case let .success(data):
                  print(data)
              case .failure(.invalidData):
                  print("Invalid data")
              case let .failure(.networkFailure(error)):
                  print(error)
              }
          }

          FinnhubClient.recommendations(symbol: "AAPL") { result in
              switch result {
              case let .success(data):
                  print(data)
              case .failure(.invalidData):
                  print("Invalid data")
              case let .failure(.networkFailure(error)):
                  print(error)
              }
          }

          FinnhubClient.priceTarget(symbol: "AAPL") { result in
              switch result {
              case let .success(data):
                  print(data)
              case .failure(.invalidData):
                  print("Invalid data")
              case let .failure(.networkFailure(error)):
                  print(error)
              }
          }

          FinnhubClient.companyProfile2(symbol: "AAPL") { result in
              switch result {
              case let .success(data):
                  print(data)
              case .failure(.invalidData):
                  print("Invalid data")
              case let .failure(.networkFailure(error)):
                  print(error)
              }
          }

         FinnhubClient.split(symbol: "AAPL", from: "2010-02-01", to: "2020-02-01") { result in
             switch result {
             case let .success(data):
                 print(data)
             case .failure(.invalidData):
                 print("Invalid data")
             case let .failure(.networkFailure(error)):
                 print(error)
             }
         }

         FinnhubClient.country() { result in
             switch result {
             case let .success(data):
                 print(data)
             case .failure(.invalidData):
                 print("Invalid data")
             case let .failure(.networkFailure(error)):
                 print(error)
             }
         }

         FinnhubClient.economicCalendar() { result in
             switch result {
             case let .success(data):
                 print(data)
             case .failure(.invalidData):
                 print("Invalid data")
             case let .failure(.networkFailure(error)):
                 print(error)
             }
         }

         FinnhubClient.fdaAdvisoryCommitteeCalendar() { result in
             switch result {
             case let .success(data):
                 print(data)
             case .failure(.invalidData):
                 print("Invalid data")
             case let .failure(.networkFailure(error)):
                 print(error)
             }
         }

         FinnhubClient.covidCasesUS() { result in
             switch result {
             case let .success(data):
                 print(data)
             case .failure(.invalidData):
                 print("Invalid data")
             case let .failure(.networkFailure(error)):
                 print(error)
             }
         }

         FinnhubClient.aggregateIndicators(symbol: "AAPL", resolution: Resolution.day) { result in
             switch result {
             case let .success(data):
                 print(data)
             case .failure(.invalidData):
                 print("Invalid data")
             case let .failure(.networkFailure(error)):
                 print(error)
             }
         }
          */

        /*
         FinnhubLiveClient.shared.subscribe(symbol: "SQ")
         FinnhubLiveClient.shared.subscribe(symbols: ["AAPL", "TSLA", "AMZN", "SQ"])
         FinnhubLiveClient.shared.receiveMessage { result in
             switch result {
             case let .success(success):
                 switch success {
                 case let .trades(trades):
                     print(trades)
                 case let .news(news):
                     print(news)
                 case let .ping(ping):
                     print(ping)
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

         DispatchQueue.main.asyncAfter(deadline: .now() + 20.0) {
             FinnhubLiveClient.shared.closeConnection()
         }
         */
    }
}
