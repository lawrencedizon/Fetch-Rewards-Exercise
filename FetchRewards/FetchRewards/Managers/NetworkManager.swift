//
//  NetworkManager.swift
//  FetchRewards
//
//  Created by Lawrence Dizon on 6/9/21.
//

import Foundation

///// This class manages  the API network calls to the SeatGeek API
final class NetworkManager {
    //MARK: - Properties
    var fetchedEvents = [Event]()
    
    //MARK: - Methods
    func fetch(type: SearchTypes){
        var url = SeatGeekEndPoints.API
        
        switch type {
            case .events:
                url += "\(SeatGeekEndPoints.events)?client_id=\(Constants.CLIENT_ID)"
            case .performers:
                url += "\(SeatGeekEndPoints.performers)?client_id=\(Constants.CLIENT_ID)"
            case .venues:
                url += "\(SeatGeekEndPoints.venues)?client_id=\(Constants.CLIENT_ID)"
        }
        print("Network call")
        print(url + "\n")
        
        guard let fetchURL = URL(string: url) else { return }
        
        let task = URLSession.shared.dataTask(with: fetchURL, completionHandler:  { [weak self] (data, response, error) in
            
            //Error
            if let error = error {
                print("Error occurred fetching \(error)")
                return
            }
            
            //Response
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                if Constants.CLIENT_ID.isEmpty{
                    print("Your CLIENT_ID is empty. Please insert a valid CLIENT_ID to use the SeatGeekAPI\n")
                }
                print("Response Error: \(String(describing: response))")
                return
            }
            
            //Data
            guard let jsonData = data else {
                print("Error with the data, no data was downloaded")
                return
            }
            
            if let apiResponse = try? JSONDecoder().decode(EventsAPIResponse.self, from: jsonData){
                for item in apiResponse.events{
                    if let city = item.venue.city,
                       let state = item.venue.state,
                       let name = item.venue.name,
                       let date = item.datetime_utc {
                            self?.fetchedEvents.append(Event(city: city, state: state, name: name, date: date))
                    }else{
                        print("Failed to decode in general")
                    }
                }
            }else{
                print("Failed to decode json data")
            }
        })
        task.resume()
    }
}
