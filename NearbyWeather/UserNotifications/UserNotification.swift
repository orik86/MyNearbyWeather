//
//  UserNotification.swift
//  NearbyWeather
//
//  Created by Aleksandr Gazizov on 13/08/2019.
//  Copyright © 2019 orik. All rights reserved.
//

import Foundation
import UserNotifications

func tempereatureNotification(temperature: Float) -> () {
    
    removeNotifications(withIdentifiers: ["myNotification"])
    
    let content = UNMutableNotificationContent()
    content.title = "Change temperature"
    content.body = "Temperature changed by " + String(temperature) + "℃"
    content.sound = UNNotificationSound.default
    
    let request = UNNotificationRequest(identifier: "myNotification", content: content, trigger: nil)
    
    let center = UNUserNotificationCenter.current()
    center.add(request, withCompletionHandler: nil)
    
}

func removeNotifications(withIdentifiers identifiers: [String])  {
    let center = UNUserNotificationCenter.current()
    center.removePendingNotificationRequests(withIdentifiers: identifiers)
}
