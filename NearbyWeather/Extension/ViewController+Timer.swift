//
//  ViewController+Timer.swift
//  NearbyWeather
//
//  Created by Aleksandr Gazizov on 13/08/2019.
//  Copyright © 2019 orik. All rights reserved.
//

import UIKit

extension ViewController {
    
    @objc func timerFunc(timer: Timer) {
        var backgroundTask = UIApplication.shared.beginBackgroundTask()
        
        updateTemperaure()
        
        if backgroundTask != UIBackgroundTaskIdentifier.invalid {
            if UIApplication.shared.applicationState == .active {
                UIApplication.shared.endBackgroundTask(backgroundTask)
                backgroundTask = UIBackgroundTaskIdentifier.invalid
            }
        }
    }
    /* update by timer */
    func timerRun() {
        let timer = Timer.init(timeInterval: 300, target: self, selector: #selector(updateTemperaure), userInfo: nil, repeats: true)
        RunLoop.current.add(timer, forMode: .common)
    }
}
