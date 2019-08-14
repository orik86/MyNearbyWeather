//
//  AllDayTemperature.swift
//  NearbyWeather
//
//  Created by Aleksandr Gazizov on 13/08/2019.
//  Copyright © 2019 orik. All rights reserved.
//

import Foundation

class AllDayTemperature: Codable {
    

    var main: OneDayTemperature
    var dt_txt: String
    var weather: [AllWeather]
    

}
