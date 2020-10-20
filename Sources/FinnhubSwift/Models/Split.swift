import Foundation

public struct Split: Codable, Equatable {
    public var symbol: String
    public var date: String
    public var fromFactor: Int
    public var toFactor: Int

    public static func == (lhs: Split, rhs: Split) -> Bool {
        return lhs.symbol == rhs.symbol &&
            lhs.date == rhs.date &&
            lhs.fromFactor == rhs.fromFactor &&
            lhs.toFactor == rhs.toFactor
    }

    /*
     [{
         "symbol":"AAPL",
         "date":"2014-06-09",
         "fromFactor":1,
         "toFactor":7
     }]
     */
}
