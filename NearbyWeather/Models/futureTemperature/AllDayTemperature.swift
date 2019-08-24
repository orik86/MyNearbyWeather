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
        case date = "dx_txt"
        case weather
    }
}
