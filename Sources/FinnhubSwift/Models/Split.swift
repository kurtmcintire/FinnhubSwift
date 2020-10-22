import Foundation

public struct Split: Mappable {
    public var symbol: String
    public var date: String
    public var fromFactor: Int
    public var toFactor: Int

    /*
     [{
         "symbol":"AAPL",
         "date":"2014-06-09",
         "fromFactor":1,
         "toFactor":7
     }]
     */
}
