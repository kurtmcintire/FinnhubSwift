# FinnhubSwift
An unnoficial Swift wrapper for Finnhub.io's API v1
https://finnhub.io/

## Features

* Get up and running quickly with Finnhub.io in your iOS or Mac app.
* Support for most free Finnhub.io REST API endpoints.
* Support for Finnhub.io's Websocket real-time trading data.
* All Finnhub.io JSON responses are mapped to native Swift objects.
* No dependencies.

## Usage

* `FinnhubClient`, used for REST GET requests.
* `FinnhubLiveClient`, used for websocket connections.

### Fetch data from Finnhub.io
```
FinnhubClient.symbols(exchange: .unitedStates) { result in
    switch result {
    case let .success(data):
        print(data) // Prints a CompanySymbol object
    case .failure(.invalidData):
        print("Invalid data")
    case let .failure(.networkFailure(error)):
        print(error)
    }
}
```

### Stream real-time trades for US stocks, forex and crypto
```
FinnhubLiveClient.shared.subscribe(symbols: ["AAPL", "AMZN", "BINANCE:BTCUSDT", "IC MARKETS:1"])
FinnhubLiveClient.shared.receiveMessage { result in
    switch result {
    case let .success(success):
    switch success {
      case let .trades(trades):
          print(trades) // Prints a LiveTrades object
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

## Available endpoints
```
FinnhubClient.symbol(query: "apple") { result in
    switch result {
    case let .success(data):
        print(data)
    case .failure(.invalidData):
        print("Invalid data")
    case let .failure(.networkFailure(error)):
        print(error)
    }
}


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
 
 FinnhubClient.quote(symbol: "AAPL") { result in
     switch result {
     case let .success(data):
         print(data)
     case .failure(.invalidData):
         print("Invalid data")
     case let .failure(.networkFailure(error)):
         print(error)
     }
 }

 FinnhubClient.country { result in
     switch result {
     case let .success(data):
         print(data)
     case .failure(.invalidData):
         print("Invalid data")
     case let .failure(.networkFailure(error)):
         print(error)
     }
 }

 FinnhubClient.economicCalendar { result in
     switch result {
     case let .success(data):
         print(data)
     case .failure(.invalidData):
         print("Invalid data")
     case let .failure(.networkFailure(error)):
         print(error)
     }
 }

 FinnhubClient.fdaAdvisoryCommitteeCalendar { result in
     switch result {
     case let .success(data):
         print(data)
     case .failure(.invalidData):
         print("Invalid data")
     case let .failure(.networkFailure(error)):
         print(error)
     }
 }

 FinnhubClient.covidCasesUS { result in
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
 
 FinnhubClient.cryptoSymbols(exchange: .binance) { result in
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

## Available real-time data
```
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
 ```

## TODOs

### Finnhub.io API endpoints
- [ ] Technical Indicators
- [ ] Pattern Recognition
- [ ] Crypto Candles
- [ ] Indices Constituents
- [ ] ETFs Industry Exposure
- [ ] ETFs Country Exposure
- [ ] Forex Exchanges
- [ ] Forex Symbol
- [ ] Forex Candles
- [ ] Forex Rates

### Tests
- [ ] Mocking web service events
- [ ] Mocking socket events

### Quality fo life
- [ ] Serialize JSON date strings into Swift Dates
