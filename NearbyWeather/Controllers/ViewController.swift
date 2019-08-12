//
//  ViewController.swift
//  NearbyWeather
//
//  Created by orik on 12/08/2019.
//  Copyright © 2019 orik. All rights reserved.
//

import UIKit

import CoreLocation

class ViewController: UIViewController {
    var ourWeather: mainWeather?
    var lastTemperature: Float = 0.0

    @IBOutlet var xLoc: UILabel!
    @IBOutlet var yLoc: UILabel!
    @IBOutlet var city: UILabel!
    @IBOutlet var curentTemperature: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        manager.delegate = self
        manager.startUpdatingLocation()
    }

    let manager: CLLocationManager = {
        let locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.distanceFilter = 5
        locationManager.pausesLocationUpdatesAutomatically = false
        locationManager.showsBackgroundLocationIndicator = false
        locationManager.allowsBackgroundLocationUpdates = true
        
        return locationManager
    }()
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations.last
        let coordinate = location?.coordinate
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(location!, completionHandler: {(placemark,error) -> Void in
            if let city = placemark?[0].self {
                self.city.text = String(city.locality!)
            }
        })
        xLoc.text = "X: " + String((coordinate!.latitude * 1000).rounded() / 1000)
        print(#line,"latitude:",xLoc.text!)
        yLoc.text = "Y: " + String((coordinate!.longitude * 1000).rounded() / 1000)
        print(#line,"longitude:",yLoc.text!)
        if coordinate != nil {
            NetworkData.shared.getWeatherInfo(lat: coordinate!.latitude, lon: coordinate!.latitude, result: {(model) in
                DispatchQueue.main.async {
                    self.curentTemperature.text = String(model.main.temp!)
                }
                self.lastTemperatureChange(nowTemperature: model.main.temp!)
                
            })
        }
    }
    
    func lastTemperatureChange(nowTemperature: Float) {
        if abs(lastTemperature - nowTemperature) > 4 {
            tempereatureNotification(temperature: (lastTemperature - nowTemperature))
            lastTemperature = nowTemperature
    
        }
    }
}




// MARK: - CLLocationManagerDelegate

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
