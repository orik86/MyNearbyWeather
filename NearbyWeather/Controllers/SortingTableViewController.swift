//
//  SortingTableViewController.swift
//  NearbyWeather
//
//  Created by orik on 15/08/2019.
//  Copyright © 2019 orik. All rights reserved.
//

import UIKit

    var nameSection: [String] = []
    var countInSection: [Int] = []
    var y = -1
    var x = 1
    var count = 0
    var lastElement = ""
class SortingTableViewController: UITableViewController {
    var allWeather: MainAllWeather?
    override func viewDidLoad() {
        super.viewDidLoad()
        tableFill()
        tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return y
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countInSection[section]
    }
    
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cells", for: indexPath)
       
        if let cod = allWeather?.list[count].main.temp {
            cell.detailTextLabel?.text = String(cod) + "℃"
            cell.textLabel?.text = allWeather?.list[count].dt_txt
            
            cell.imageView?.image = UIImage(named: allWeather!.list[count].weather[0].icon)
        } else {
            cell.detailTextLabel?.text = "none"
        }
        if count < 39 {
            count += 1} else { count = 0 }
        return cell
    }
    
    func tableFill() {
        countInSection.removeAll()
        nameSection.removeAll()
        if let count = allWeather?.list.count {
            for i in 0...count-1 {
                    var currentElement = allWeather!.list[i].dt_txt
                    let rangeCurent = currentElement.index(currentElement.endIndex, offsetBy: -8)..<currentElement.endIndex
                    currentElement.removeSubrange(rangeCurent)
                if currentElement == lastElement { x += 1
                    
                } else {
                    lastElement = allWeather!.list[i].dt_txt
                    let rangeLast = lastElement.index(lastElement.endIndex, offsetBy: -8)..<lastElement.endIndex
                    lastElement.removeSubrange(rangeLast)
                    print(lastElement)
                    y += 1
                    print(">>>>", x)
                    if i != 0 {
                    countInSection.append(x)
                    x = 1
                    }
                    print(">>>>", y)
                    nameSection.append(lastElement)
                }
            }
            countInSection.append(x)
        } else {return}
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return nameSection[section]
       
    }

}
