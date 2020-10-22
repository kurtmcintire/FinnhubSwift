import Foundation

public struct CompanySymbol: Codable, Equatable, Hashable {
    public var currency: String
    public var description: String
    public var displaySymbol: String
    public var symbol: String
    public var type: String
}
