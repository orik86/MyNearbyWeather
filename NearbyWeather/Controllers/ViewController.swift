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
    var ourWeather: MainWeather?
    var lastTemperature: Float = 0.0
    var coordinate: CLLocationCoordinate2D?
   
    
    @IBOutlet var xLoc: UILabel!
    @IBOutlet var yLoc: UILabel!
    @IBOutlet var city: UILabel!
    @IBOutlet var curentTemperature: UILabel!
    @IBOutlet var currentPressure: UILabel!
    @IBOutlet var currentHumidity: UILabel!
   
    @IBOutlet var nextButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        manager.delegate = self
        manager.startUpdatingLocation()
        timerRun()
        updateUI()
        
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
        coordinate = location?.coordinate
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(location!, completionHandler: {(placemark,error) -> Void in
            if let city = placemark?[0].self {
                self.city.text = String(city.locality!)
            }
        })
        xLoc.text = "Lat: " + String((coordinate!.latitude * 1000).rounded() / 1000)
        print(#line,"latitude:",xLoc.text!)
        yLoc.text = "Long: " + String((coordinate!.longitude * 1000).rounded() / 1000)
        print(#line,"longitude:",yLoc.text!)
        if coordinate != nil { updateTemperaure() }
    }
    
    func lastTemperatureChange(nowTemperature: Float) {
        if abs(lastTemperature - nowTemperature) > 3 {
            tempereatureNotification(temperature: (lastTemperature - nowTemperature))
            lastTemperature = nowTemperature
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "allWeatherSegue" {
            let allWeather = segue.destination as! TableViewController
            allWeather.lat = coordinate!.latitude
            allWeather.lon = coordinate!.longitude
        }
    }
    
    @objc func updateTemperaure() {
        NetworkData.shared.getWeatherInfo(lat: coordinate!.latitude, lon: coordinate!.latitude, result: {(model) in
            DispatchQueue.main.async {
                self.curentTemperature.text = String(model.main.temp!) + "℃"
                self.currentPressure.text = String(model.main.pressure!) + "hPa"
                self.currentHumidity.text = String(model.main.humidity!) + "%"
            }
            self.lastTemperatureChange(nowTemperature: model.main.temp!)
        })
    }
    
    func updateUI() {
        let lCurrentWidth = self.view.frame.size.width;
        let size = 0.05 * lCurrentWidth
        let stackViews = self.view.subviews.compactMap{($0 as? UIStackView)}
        nextButton.titleLabel?.font = UIFont(name: "Helvetica", size: size)
        for stakView in stackViews {
        
            let labels = stakView.arrangedSubviews.compactMap{($0 as? UILabel)}
            for label in labels {
                label.font = UIFont(name: "Helvetica", size: size)
        }
        
    }
}

}

