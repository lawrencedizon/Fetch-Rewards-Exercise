//
//  Constants.swift
//  FetchRewards
//
//  Created by Lawrence Dizon on 6/9/21.
//

import Foundation

struct Constants {
    //Place your client_id or Secret from the SeatGeekAPI here
    static let CLIENT_ID = "MjIxNzQzNzJ8MTYyMzI3MTAyOC42NTA4NDMx"
    static let SECRET = ""
    static let favorites = "favorites"
}

enum SearchTypes {
    case events, performers, venues
}

struct SeatGeekEndPoints{
    static let API = "https://api.seatgeek.com/2"
    static let events = "/events"
    static let performers = "/performers"
    static let venues = "/venues"
}





