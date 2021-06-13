//
//  Events.swift
//  FetchRewards
//
//  Created by Lawrence Dizon on 6/9/21.
//

import Foundation

struct Event {
    let eventTitle: String
    let city: String
    let state: String
    let venueName: String
    let date: String
    let performers: [String]
    
    init(eventTitle: String, city: String, state: String, venueName: String, performers: [String], date: String){
        self.eventTitle = eventTitle
        self.city = city
        self.state = state
        self.venueName = venueName
        self.date = date
        self.performers = performers
    }
    
}
