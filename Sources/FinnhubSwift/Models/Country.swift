import Foundation

public struct Country: Codable, Equatable {
    var code2: String
    var code3: String
    var codeNo: Int
    var country: String
    var currency: String
    var currencyCode: String

    public static func == (lhs: Country, rhs: Country) -> Bool {
        return lhs.codeNo == rhs.codeNo
    }
}
