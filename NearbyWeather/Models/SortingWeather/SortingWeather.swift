//
//  File.swift
//  NearbyWeather
//
//  Created by orik on 18/08/2019.
//  Copyright © 2019 orik. All rights reserved.
//

import Foundation

struct SortingWeather {
    var expanded: Bool
    var currentDayTemperature = [AllDayTemperature?]()
    
    init() {
        self.expanded = false
        self.currentDayTemperature = []
    }
    
}
