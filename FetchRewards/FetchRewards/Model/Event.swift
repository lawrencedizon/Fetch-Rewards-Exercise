//
//  Events.swift
//  FetchRewards
//
//  Created by Lawrence Dizon on 6/9/21.
//

import UIKit

class Event: NSObject, Codable{
    let eventTitle: String
    let city: String
    let state: String
    let venueName: String
    let date: String
    let performerNames: [String]
    let performerImages: [String]
    let ticketURL: String
    var isFavorite: Bool
    
    init(eventTitle: String, city: String, state: String, venueName: String, performerNames: [String], date: String, performerImages: [String], ticketURL: String, isFavorite: Bool){
        self.eventTitle = eventTitle
        self.city = city
        self.state = state
        self.venueName = venueName
        self.date = date
        self.performerNames = performerNames
        self.performerImages = performerImages
        self.ticketURL = ticketURL
        self.isFavorite = isFavorite
    }
}

