# FinnhubSwift
An unnoficial Swift wrapper for Finnhub.io's API v1
https://finnhub.io/

## Features

* Support for most free Finnhub.io REST API endpoints.
* Support for Finnhub.io's Websocket `Trades` trading data.

## Usage

* FinnhubClient, used for REST GET requests.
* FinnhubLiveClient, used for websocket connections.

### Fetch data from Finnhub.io
```
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
```

### Stream real-time trades for US stocks, forex and crypto:
```
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
```

Disconnect from the websocket:
```
FinnhubLiveClient.shared.closeConnection()
```

## Installation
### 1. Add via Swift Package manager

* In Xcode, go to File -> Swift Packages -> Add Package Dependency
* Enter this repository's clone URL
```
https://github.com/kurtmcintire/FinnhubSwift.git
```

### 2. Securely add your Finnhub API key

* Retrieve your Finnhub API key from https://finnhub.io/register.
* Create a new Property List file, named Finnhub-Info.plist, at the root of your project.

Add the following information to your .plist
* Key: `API_KEY`
* Type: `String`
* Value: `<YOUR_API_KEY>`

Add this path to your .gitignore
```
Finnhub-Info.plist
```

### 3. Import the framework
```
import FinnhubSwift
```
