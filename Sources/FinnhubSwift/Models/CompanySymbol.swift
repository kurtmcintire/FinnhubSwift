import Foundation

public struct CompanySymbol: Codable, Equatable {
    var currency: String
    var description: String
    var displaySymbol: String
    var symbol: String
    var type: String

    public static func == (lhs: CompanySymbol, rhs: CompanySymbol) -> Bool {
        return lhs.currency == rhs.currency &&
            lhs.description == rhs.description &&
            lhs.displaySymbol == rhs.displaySymbol &&
            lhs.symbol == rhs.symbol &&
            lhs.type == rhs.type
    }
}
