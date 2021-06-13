//
//  Events.swift
//  FetchRewards
//
//  Created by Lawrence Dizon on 6/9/21.
//

import Foundation

struct EventsAPIResponse: Codable{
    let events: [EventInfo]
}

struct EventInfo: Codable {
    let short_title: String?
    let datetime_utc: String?
    let venue: VenueInfo
    let performers: [PerformerInfo]
    let url: String?
}

struct PerformerInfo: Codable {
    let name:  String?
    let image: String?
}
struct VenueInfo: Codable {
    let name:  String?
    let city:  String?
    let state: String?
}
