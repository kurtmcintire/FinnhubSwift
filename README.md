# FinnhubSwift
An unnoficial Swift wrapper for Finnhub.io's API v1
https://finnhub.io/

## Features

* Support for most free Finnhub.io REST API endpoints.
* Support for Finnhub.io's Websocket `Trades` trading data.

## Installation
### 1. Add via Swift Package manager

* In Xcode, go to File -> Swift Packages -> Add Package Dependency
* Enter this repository's clone URL https://github.com/kurtmcintire/FinnhubSwift.git

### 2. Add your Finnhub API key

* Retrieve your Finnhub API key from https://finnhub.io/register.
* Create a new Property List file, named Finnhub-Info.plist, at the root of your project.

Add the following information to your .plist
* Key: `API_KEY`
* Type: `String`
* Value: `<YOUR_API_KEY>`
