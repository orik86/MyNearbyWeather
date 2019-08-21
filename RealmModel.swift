//
//  RealmModel.swift
//  NearbyWeather
//
//  Created by Aleksandr Gazizov on 21/08/2019.
//  Copyright © 2019 orik. All rights reserved.
//

import Foundation
import RealmSwift

class Temperature: Object {
    @objc dynamic var city = "Loading..."
    @objc dynamic var temp = 0.0
    @objc dynamic var pressure = 0.0
    @objc dynamic var hummidity = 0.0
}
