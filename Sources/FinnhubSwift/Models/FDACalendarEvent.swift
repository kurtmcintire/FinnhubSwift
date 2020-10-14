import Foundation

public struct FDACalendarEvent: Codable, Equatable {
    var fromDate: String
    var toDate: String
    var eventDescription: String
    var url: String

    public static func == (lhs: FDACalendarEvent, rhs: FDACalendarEvent) -> Bool {
        return lhs.fromDate == rhs.fromDate &&
            lhs.toDate == rhs.toDate &&
            lhs.eventDescription == rhs.eventDescription &&
            lhs.url == rhs.url
    }
}
