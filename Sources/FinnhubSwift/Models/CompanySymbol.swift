import Foundation

public struct CompanySymbol: Codable, Equatable {
    public var currency: String
    public var description: String
    public var displaySymbol: String
    public var symbol: String
    public var type: String

    public static func == (lhs: CompanySymbol, rhs: CompanySymbol) -> Bool {
        return lhs.currency == rhs.currency &&
            lhs.description == rhs.description &&
            lhs.displaySymbol == rhs.displaySymbol &&
            lhs.symbol == rhs.symbol &&
            lhs.type == rhs.type
    }
}
