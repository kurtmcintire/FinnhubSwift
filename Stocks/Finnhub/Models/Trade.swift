import Foundation

struct Trade: Codable {
    var p: Double // Last price
    var s: String // Symbol
    var t: Int // UNIX milliseconds timestamp
    var v: Double // Volume
}
