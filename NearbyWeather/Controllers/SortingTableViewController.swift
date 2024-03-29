//
//  SortingTableViewController.swift
//  NearbyWeather
//
//  Created by orik on 15/08/2019.
//  Copyright © 2019 orik. All rights reserved.
//

import UIKit

class SortingTableViewController: UITableViewController, ExpandableHeaderViewDelegate {
    
    var allWeather: MainAllWeather?
    var nameSection: [String] = []
    var sortWeather: [SortingWeather] = []
   
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
        
        return sortWeather[section].currentDayTemperature.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cells", for: indexPath)
        var text = sortWeather[indexPath.section].currentDayTemperature[indexPath.row]!.date
        text.removeFirst(11)
            cell.detailTextLabel?.text = String(sortWeather[indexPath.section].currentDayTemperature[indexPath.row]!.main.temp) + "℃"
            cell.textLabel?.text = text
            cell.imageView?.image = UIImage(named: sortWeather[indexPath.section].currentDayTemperature[indexPath.row]!.weather[0].icon)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = HeaderFooterView()
        header.setup(withTitle: nameSection[section],size: textSize(view: self.view), section: section, delegate: self)
        return header
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return  textSize(view: self.view)
        
    }
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 2
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if sortWeather[indexPath.section].expanded {
            return UITableView.automaticDimension
        }
        return 0
    }
    
    
    // MARK: - my func
    func tableFill() {
        var x: Int = -1
        var lastElement: String = ""
        
        if let counters = allWeather?.list.count {
            for i in 0...counters-1 {
                var currentElement = allWeather!.list[i].date
                let rangeCurent = currentElement.index(currentElement.endIndex, offsetBy: -8)..<currentElement.endIndex
                currentElement.removeSubrange(rangeCurent)
                if currentElement == lastElement {
                    sortWeather[x].currentDayTemperature.append(allWeather!.list[i])
                } else {
                    if allWeather?.list[i].date != nil {
                        sortWeather.append(SortingWeather())
                        x += 1
                        sortWeather[x].currentDayTemperature.append(allWeather!.list[i])
                    }
                    lastElement = allWeather!.list[i].date
                    let rangeLast = lastElement.index(lastElement.endIndex, offsetBy: -8)..<lastElement.endIndex
                    lastElement.removeSubrange(rangeLast)
                    nameSection.append(lastElement)
                }
            }
        } else {return}
    }
    
    func toggleSection(header: HeaderFooterView, section: Int) {
        sortWeather[section].expanded = !sortWeather[section].expanded
        
        tableView.beginUpdates()
        for row in 0..<sortWeather[section].currentDayTemperature.count {
            tableView.reloadRows(at: [IndexPath(row: row, section: section)], with: .automatic)
        }
        tableView.endUpdates()
    }

    
}
