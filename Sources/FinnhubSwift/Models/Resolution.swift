import Foundation

public enum Resolution: String, Equatable, Hashable {
    case month = "M"
    case week = "W"
    case day = "D"
    case minutes60 = "60"
    case minutes30 = "30"
    case minutes15 = "15"
    case minutes5 = "5"
    case minutes1 = "1"
}
