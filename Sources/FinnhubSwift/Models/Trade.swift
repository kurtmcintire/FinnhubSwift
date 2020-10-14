import Foundation

public struct Trade: Codable, Equatable {
    var p: Double // Last price
    var s: String // Symbol
    var t: Int // UNIX milliseconds timestamp
    var v: Double // Volume

    public static func == (lhs: Trade, rhs: Trade) -> Bool {
        return lhs.p == rhs.p &&
            lhs.s == rhs.s &&
            lhs.t == rhs.t &&
            lhs.v == rhs.v
    }
}
