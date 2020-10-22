import Foundation

public struct Country: Mappable {
    public var codeTwo: String
    public var codeThree: String
    public var codeNo: String
    public var country: String
    public var currency: String
    public var currencyCode: String

    enum CodingKeys: String, CodingKey {
        case codeTwo = "code2"
        case codeThree = "code3"
        case codeNo
        case country
        case currency
        case currencyCode
    }

    /*
     [{
          "code2":"NR",
          "code3":"NRU",
          "codeNo":"520",
          "country":"Nauru",
          "currency":"Australian Dollars",
          "currencyCode":"AUD"
     }]
     */
}
