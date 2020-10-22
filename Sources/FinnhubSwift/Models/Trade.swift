import Foundation

public struct Trade: Mappable {
    public var p: Double // Last price
    public var s: String // Symbol
    public var t: Int // UNIX milliseconds timestamp
    public var v: Double // Volume
}
