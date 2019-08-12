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

    @IBOutlet var xLoc: UILabel!
    
    @IBOutlet var yLoc: UILabel!
    
    @IBOutlet var city: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        manager.delegate = self
        manager.startUpdatingLocation()
    }

    let manager: CLLocationManager = {
        let locationManager = CLLocationManager()
        //
        locationManager.desiredAccuracy = 1
        locationManager.distanceFilter = 5
        locationManager.pausesLocationUpdatesAutomatically = false
        locationManager.showsBackgroundLocationIndicator = true
        
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
        xLoc.text = String((coordinate!.latitude * 1000).rounded() / 1000)
        yLoc.text = String((coordinate!.longitude * 1000).rounded() / 1000)
        
        if location != nil {
        getWeatherInfo(lat: coordinate!.latitude, lon: coordinate!.longitude)
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
                print("It's ok")
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
