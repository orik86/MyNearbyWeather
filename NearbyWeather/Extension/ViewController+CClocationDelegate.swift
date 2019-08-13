//
//  ViewController+CClocationDelegate.swift
//  NearbyWeather
//
//  Created by Aleksandr Gazizov on 13/08/2019.
//  Copyright © 2019 orik. All rights reserved.
//

import CoreLocation

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        switch status {
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            print("No work")
        case .authorizedAlways:
            print("mogno?")
        case .authorizedWhenInUse:
            print("robim")
            manager.requestAlwaysAuthorization()
        @unknown default:
            print("WhatIsThis?")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        guard let locationError = error as? CLError else {
            print(error)
            return
        }
        print(locationError.errorCode)
    }
}
