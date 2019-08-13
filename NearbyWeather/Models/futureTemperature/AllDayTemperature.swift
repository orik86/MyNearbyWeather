//
//  AllDayTemperature.swift
//  NearbyWeather
//
//  Created by Aleksandr Gazizov on 13/08/2019.
//  Copyright © 2019 orik. All rights reserved.
//

import Foundation

class AllDayTemperature: Codable {
    
    var dt: Date
    var pressure: Float
    var humidity: Float
    var speed: Float
    var clouds: Float
    var rain: Float?
    var snow: Float?

}
