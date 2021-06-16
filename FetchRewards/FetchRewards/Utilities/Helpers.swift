//
//  Helpers.swift
//  FetchRewards
//
//  Created by Lawrence Dizon on 6/13/21.
//

import Foundation

func splitDate(date: String, index: Int) -> String{
    return date.components(separatedBy: "T")[index]
}

func formatTimeString(time: String) -> String {
    var result = time.dropFirst(1).replacingOccurrences(of: "^0*", with: "", options: .regularExpression)
    result = result.dropLast(2).replacingOccurrences(of: "^0*^:*", with: "", options: .regularExpression).dropLast() + " AM"
    return result
}

func convertDateToString(_ date: String) -> String{
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    let date = dateFormatter.date(from: date)
    
    let formattedDisplayDate = DateFormatter()
    formattedDisplayDate.dateFormat = "MMM d, yyyy"
    
    guard let safeDate = date else { return "" }
    return formattedDisplayDate.string(from: safeDate)
}
