//
//  TableViewController.swift
//  NearbyWeather
//
//  Created by Aleksandr Gazizov on 14/08/2019.
//  Copyright © 2019 orik. All rights reserved.
//


import UIKit

class TableViewController: UITableViewController {
    var numbers = 0
    var numbersOfSection = 0
    var allWeather: MainAllWeather?
    var lat: Double = 0.0
    var lon: Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LoadData(lat: lat, lon: lon)
    }
    
    // MARK: - Table view data source
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let number = allWeather?.list.count {
            return number
        } else {return 0}
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Date:Time"
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cells", for: indexPath)
        let lCurrentWidth = self.view.frame.size.width;
        let size = 0.05 * lCurrentWidth
        cell.detailTextLabel?.font = UIFont(name: "Helvetica", size: size)
        cell.textLabel?.font = UIFont(name: "Helvetica", size: size)
        if let cod = allWeather?.list[indexPath.row].main.temp {
            cell.detailTextLabel?.text = String(cod) + "℃"
            cell.textLabel?.text = allWeather?.list[indexPath.row].dt_txt
           // print(AllWeather!.list[indexPath.row].weather[0].icon)
            cell.imageView?.image = UIImage(named: allWeather!.list[indexPath.row].weather[0].icon)
        } else {
            cell.detailTextLabel?.text = "none"
        }
        return cell
    }
    

    func LoadData(lat: Double, lon: Double) {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.openweathermap.org"
        urlComponents.path = "/data/2.5/forecast"
        urlComponents.queryItems = [URLQueryItem(name: "lat", value: String(lat)),
                                    URLQueryItem(name: "lon", value: String(lon)),
                                    URLQueryItem(name: "units", value: "metric"),
                                    URLQueryItem(name: "appid", value: "57c7cb446dbc8918541b6ce92073239e")]
        
        let request = URLRequest(url: urlComponents.url!)
        print(request)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let data = data else { return }
            guard error == nil else { return }
            
            do {
                let decoderAllWeather = try JSONDecoder().decode(MainAllWeather.self, from: data)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
                self.allWeather = decoderAllWeather
            } catch let error {
                print(error)
            }
            }.resume()
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sortingSegue" {
          let sortingView = segue.destination as! SortingTableViewController
            sortingView.allWeather = allWeather
        }
    }
}
