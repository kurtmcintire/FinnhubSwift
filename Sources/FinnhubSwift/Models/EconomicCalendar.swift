import Foundation

public struct EconomicEvent: Codable, Equatable {
    var actual: Double
    var country: String
    var estimate: Double
    var event: String
    var impact: String
    var prev: Int
    var time: String
    var unit: String

    public static func == (lhs: EconomicEvent, rhs: EconomicEvent) -> Bool {
        return lhs.actual == rhs.actual &&
            lhs.country == rhs.country &&
            lhs.estimate == rhs.estimate &&
            lhs.event == rhs.event &&
            lhs.impact == rhs.impact &&
            lhs.prev == rhs.prev &&
            lhs.time == rhs.time &&
            lhs.unit == rhs.unit
    }
}

public struct EconomicCalendar: Codable, Equatable {
    var economicCalendar: [EconomicEvent]

    public static func == (lhs: EconomicCalendar, rhs: EconomicCalendar) -> Bool {
        return lhs.economicCalendar == rhs.economicCalendar
    }
}