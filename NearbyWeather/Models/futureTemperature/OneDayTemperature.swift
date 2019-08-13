//
//  AllDayTemperature.swift
//  NearbyWeather
//
//  Created by Aleksandr Gazizov on 13/08/2019.
//  Copyright © 2019 orik. All rights reserved.
//

import Foundation


class OneDayTemperature: Codable {
    var temp: [AllDayTemperature]
    var day: Float
    var min: Float
    var max: Float
    var night: Float
    var eve: Float
    var morn: Float
}
