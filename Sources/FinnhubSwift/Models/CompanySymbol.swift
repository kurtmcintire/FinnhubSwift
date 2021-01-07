import Foundation

public struct CompanySymbol: Mappable {
    public var description: String
    public var displaySymbol: String
    public var symbol: String
    public var type: String
    public var currency: String?
    public var figi: String?
    public var mic: String?
}
