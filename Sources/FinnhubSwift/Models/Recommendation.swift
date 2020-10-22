import Foundation

public struct Recommendation: Mappable {
    public var buy: Int
    public var hold: Int
    public var period: String
    public var sell: Int
    public var strongBuy: Int
    public var strongSell: Int
    public var symbol: String
}
