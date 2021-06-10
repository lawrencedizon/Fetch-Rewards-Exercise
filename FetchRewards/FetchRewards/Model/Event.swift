//
//  Events.swift
//  FetchRewards
//
//  Created by Lawrence Dizon on 6/9/21.
//

import Foundation

struct Event {
    let city: String
    let state: String
    let name: String
    let date: String
    
    init(city: String, state: String, name: String, date: String){
        self.city = city
        self.state = state
        self.name = name
        self.date = date
    }
    
}
