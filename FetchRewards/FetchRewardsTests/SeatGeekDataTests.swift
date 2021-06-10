//
//  SeatGeekDataTests.swift
//  FetchRewardsTests
//
//  Created by Lawrence Dizon on 6/9/21.
//

import XCTest
@testable import FetchRewards
class SeatGeekDataTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCanParseEventsEndpointViaJSONFile() throws{
        
        guard let pathString = Bundle(for: type(of: self)).path(forResource: "SeatGeekEventsSampleResponse", ofType: "json") else {
            fatalError("json file not found")
        }
        
        guard let json = try? String(contentsOfFile: pathString, encoding: .utf8)
        else{
            fatalError("Unable to convert json to String")
        }
        
        let jsonData = json.data(using: .utf8)!
        let eventsData = try! JSONDecoder().decode(EventsAPIResponse.self, from: jsonData)
        
        XCTAssertEqual("Loveland",eventsData.events[0].venue.city)
        XCTAssertEqual("CO", eventsData.events[0].venue.state)
        XCTAssertEqual("Budweiser Events Center",eventsData.events[0].venue.name)
        XCTAssertEqual("2021-06-09T09:30:00", eventsData.events[0].datetime_utc)
    }
}
