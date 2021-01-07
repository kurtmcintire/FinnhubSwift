import Foundation

public struct CompanySymbolQueryResult: Mappable {
    public var count: Int
    public var result: [CompanySymbol]
}
