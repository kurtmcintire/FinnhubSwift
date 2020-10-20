import Foundation

public struct FDACalendarEvent: Codable, Equatable {
    public var fromDate: String
    public var toDate: String
    public var eventDescription: String
    public var url: String

    public static func == (lhs: FDACalendarEvent, rhs: FDACalendarEvent) -> Bool {
        return lhs.fromDate == rhs.fromDate &&
            lhs.toDate == rhs.toDate &&
            lhs.eventDescription == rhs.eventDescription &&
            lhs.url == rhs.url
    }
}
