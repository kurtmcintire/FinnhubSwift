import Foundation

public protocol LiveResponse {
    var type: String { get set }
}

public enum LiveResponseType: String {
    case trade
    case news
    case ping
}
