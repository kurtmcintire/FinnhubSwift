import Foundation

public struct Trade: Codable, Equatable {
    public var p: Double // Last price
    public var s: String // Symbol
    public var t: Int // UNIX milliseconds timestamp
    public var v: Double // Volume

    public static func == (lhs: Trade, rhs: Trade) -> Bool {
        return lhs.p == rhs.p &&
            lhs.s == rhs.s &&
            lhs.t == rhs.t &&
            lhs.v == rhs.v
    }
}
