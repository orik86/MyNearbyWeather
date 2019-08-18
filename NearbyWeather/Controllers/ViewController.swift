//
//  ViewController.swift
//  NearbyWeather
//
//  Created by orik on 12/08/2019.
//  Copyright © 2019 orik. All rights reserved.
//

import UIKit
import CoreLocation
import RealmSwift


class ViewController: UIViewController {
    var ourWeather: MainWeather?
    var lastTemperature: Float = 0.0
    var coordinate: CLLocationCoordinate2D?
    let baseTemeprature = Temperature()
    let realm = try! Realm()
    
    @IBOutlet var xLoc: UILabel!
    @IBOutlet var yLoc: UILabel!
    @IBOutlet var city: UILabel!
    @IBOutlet var curentTemperature: UILabel!
    @IBOutlet var currentPressure: UILabel!
    @IBOutlet var currentHumidity: UILabel!
    @IBOutlet var nextButton: UIButton!
    @IBOutlet var helloLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        manager.delegate = self
        manager.startUpdatingLocation()
        loadBase()
        timerRun()
        updateUI()
        animateHello()
        self.view.addBackground()
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
    func loadBase () {
        if realm.objects(Temperature.self).count == 0 {
            try! realm.write {
                realm.add(baseTemeprature)
            }
        }
        let lastWeather = realm.objects(Temperature.self)
        city.text = lastWeather.last?.city ?? "none"
        curentTemperature.text = String((round(lastWeather.last?.temp ?? 0.0) * 1000) / 1000) + " ℃"
        currentHumidity.text = String((round(lastWeather.last?.hummidity ?? 1.0) * 1000) / 1000) + " %"
        currentPressure.text = String((round(lastWeather.last?.pressure ?? 1.0) * 1000) / 1000) + " hPa"
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations.last
        coordinate = location?.coordinate
        if coordinate != nil { nextButton.isEnabled = true } else { nextButton.isEnabled = false}
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(location!, completionHandler: {(placemark,error) -> Void in
            if let city = placemark?[0].self {
                self.city.text = city.locality!
                 let lastWeather = self.realm.objects(Temperature.self)
                 try! self.realm.write {
                    lastWeather.last?.city = city.locality!
                }
            }
        })
        xLoc.text = "Lat: " + String((coordinate!.latitude * 1000).rounded() / 1000)
        yLoc.text = "Long: " + String((coordinate!.longitude * 1000).rounded() / 1000)
       
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
            let allWeatherView = segue.destination as! TableViewController
                allWeatherView.lat = coordinate!.latitude
                allWeatherView.lon = coordinate!.longitude
        }
    }
    
    @objc func updateTemperaure() {
        NetworkData.shared.getWeatherInfo(lat: coordinate!.latitude, lon: coordinate!.latitude, result: {(model) in
            DispatchQueue.main.async {
                let lastWeather = self.realm.objects(Temperature.self)
                try! self.realm.write {
                    lastWeather.last?.temp = Double(model.main.temp!)
                    lastWeather.last?.pressure = Double(model.main.pressure!)
                    lastWeather.last?.hummidity = Double(model.main.humidity!)
                }
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
        nextButton.titleLabel?.font = UIFont(name: "Helvetica", size: (size + 5))
        helloLabel.font = UIFont(name: "Helvetica", size: (size + 20))
        
        UIView.animate(withDuration: 5, animations: {
            for stakView in stackViews {
                stakView.alpha = 100
                let labels = stakView.arrangedSubviews.compactMap{($0 as? UILabel)}
                for label in labels {
                    label.font = UIFont(name: "Helvetica", size: size)
                }
            }
        })
    }
}

extension UIView {
    func addBackground() {
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        
        let imageViewBackground = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        let date = Date()
        let formatDate = DateFormatter()
        formatDate.dateFormat = "HH"
       
        let formatedDate = formatDate.string(from: date)
        
        if (Int(formatedDate)! > 8) && (Int(formatedDate)! < 19) {
            imageViewBackground.image = UIImage(named: "day.jpg")
        } else {
            imageViewBackground.image = UIImage(named: "night.jpg")
        }
        imageViewBackground.contentMode = UIView.ContentMode.scaleAspectFill
        
        self.addSubview(imageViewBackground)
        self.sendSubviewToBack(imageViewBackground)
    }
}
    


