import Foundation

public struct Split: Codable, Equatable {
    var symbol: String
    var date: String
    var fromFactor: Int
    var toFactor: Int

    public static func == (lhs: Split, rhs: Split) -> Bool {
        return lhs.symbol == rhs.symbol &&
            lhs.date == rhs.date &&
            lhs.fromFactor == rhs.fromFactor &&
            lhs.toFactor == rhs.toFactor
    }
}
