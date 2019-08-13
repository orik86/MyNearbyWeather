//
//  TableViewController.swift
//  NearbyWeather
//
//  Created by Aleksandr Gazizov on 14/08/2019.
//  Copyright © 2019 orik. All rights reserved.
//

import UIKit


class TableViewController: UITableViewController {

    var lon: Double = 0.0
    var lat: Double = 0.0
    var allWeatherData: MainAllWeather?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateData()

    }

    
    func updateData() {
        AllNetworkData.shared.getWeatherInfo(lat: lat, lon: lon, result: {(model) in
            
                self.allWeatherData = model
                print(self.allWeatherData!)
            
        })
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
       // if let count = allWeatherData?.list.count { return count
     //   } else {
            let count = 1
            return count
     //   }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 5
    }
    
 /*   override func tableView( _ tableView : UITableView,  titleForHeaderInSection section: Int)->String? {
        
        let dataFormater = DateFormatter()
        dataFormater.dateStyle = .short
        dataFormater.timeStyle = .short
        let date = dataFormater.string(from: allWeatherData!.list[section].dt)
        
        return date + "  " + String(allWeatherData!.list[section].temp.day)
    }
   */
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cells", for: indexPath)

        cell.textLabel?.text = String(indexPath.row)
        cell.detailTextLabel?.text = String(indexPath.section)

        return cell
    }
   


}
