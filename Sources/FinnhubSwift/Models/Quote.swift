import Foundation

public struct Quote: Mappable {
    public var open: Float
    public var high: Float
    public var low: Float
    public var current: Float
    public var previousClose: Float
    public var timestamp: Int

    enum CodingKeys: String, CodingKey {
        case open = "o"
        case high = "h"
        case low = "l"
        case current = "c"
        case previousClose = "pc"
        case timestamp = "t"
    }
}

/*
 {
   "c": 261.74,
   "h": 263.31,
   "l": 260.68,
   "o": 261.07,
   "pc": 259.45,
   "t": 1582641000
 }
 */
