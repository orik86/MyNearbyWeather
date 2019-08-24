//
//  AllDayTemperature.swift
//  NearbyWeather
//
//  Created by Aleksandr Gazizov on 13/08/2019.
//  Copyright © 2019 orik. All rights reserved.
//

import Foundation

class AllDayTemperature: Codable {
    
    let main: OneDayTemperature
    let date: String
    let weather: [AllWeather]
    
    
    enum CodingKeys: String, CodingKey {
        case main
        case date = "dt_txt"
        case weather
    }
}
extension AllDayTemperature {
    func localdate() -> String {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd HH:mm:ss"
        guard let localDate = dateFormater.date(from: date) else { return date }
        
        let newDateFormater = DateFormatter()
        newDateFormater.dateFormat = "dd.MM.yyyy HH:mm:ss"
        let stringDate = newDateFormater.string(from: localDate)
        return stringDate
    }
}
