import Foundation

public struct FDACalendarEvent: Codable, Equatable, Hashable {
    public var fromDate: String
    public var toDate: String
    public var eventDescription: String
    public var url: String
}
