//
//  SortingTableViewController.swift
//  NearbyWeather
//
//  Created by orik on 15/08/2019.
//  Copyright © 2019 orik. All rights reserved.
//

import UIKit

class SortingTableViewController: UITableViewController {
    
    var allWeather: MainAllWeather?
    var nameSection: [String] = []
    var sortWeather: [[AllDayTemperature?]] = []
    
    var x: Int = -1
    var count = 0
    var lastElement: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableFill()
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sortWeather.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortWeather[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cells", for: indexPath)
        
        cell.detailTextLabel?.text = String(sortWeather[indexPath.section][indexPath.row]!.main.temp) + "℃"
        cell.textLabel?.text = sortWeather[indexPath.section][indexPath.row]!.dt_txt
        cell.imageView?.image = UIImage(named: sortWeather[indexPath.section][indexPath.row]!.weather[0].icon)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return nameSection[section]
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 44
    }
    
  
    // MARK: - my func
    func tableFill() {
        
        if let counters = allWeather?.list.count {
            for i in 0...counters-1 {
                var currentElement = allWeather!.list[i].dt_txt
                let rangeCurent = currentElement.index(currentElement.endIndex, offsetBy: -8)..<currentElement.endIndex
                currentElement.removeSubrange(rangeCurent)
                if currentElement == lastElement {
                    sortWeather[x].append(allWeather!.list[i])
                } else {
                    if allWeather?.list[i].dt_txt != nil {
                        sortWeather.append([])
                        x += 1
                        sortWeather[x].append(allWeather!.list[i])
                    }
                    lastElement = allWeather!.list[i].dt_txt
                    let rangeLast = lastElement.index(lastElement.endIndex, offsetBy: -8)..<lastElement.endIndex
                    lastElement.removeSubrange(rangeLast)
                    nameSection.append(lastElement)
                }
            }
        } else {return}
    }
}
