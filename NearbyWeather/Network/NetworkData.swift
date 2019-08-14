//
//  NetworkData.swift
//  NearbyWeather
//
//  Created by orik on 12/08/2019.
//  Copyright © 2019 orik. All rights reserved.
//

import Foundation

class NetworkData {
    private init() {  }
    static let shared: NetworkData = NetworkData()
    

func getWeatherInfo(lat: Double, lon: Double, result: @escaping ((MainWeather) -> ())) {
   
    var urlComponents = URLComponents()
    urlComponents.scheme = "https"
    urlComponents.host = "api.openweathermap.org"
    urlComponents.path = "/data/2.5/weather"
    urlComponents.queryItems = [URLQueryItem(name: "lat", value: String(lat)), URLQueryItem(name: "lon", value: String(lon)), URLQueryItem(name: "units", value: "metric"), URLQueryItem(name: "appid", value: "57c7cb446dbc8918541b6ce92073239e")]

    var request = URLRequest(url: urlComponents.url!)
   
    request.httpMethod = "GET"
    let task = URLSession(configuration: .default)
   
    task.dataTask(with: request) { (data, response, error) in
        guard error == nil else { return }
        var decoderWeather: MainWeather?
        
        if data != nil {
            decoderWeather = try? JSONDecoder().decode(MainWeather.self, from: data!)
            result(decoderWeather!)
            
            let dataFormater = DateFormatter()
            dataFormater.dateStyle = .short
            dataFormater.timeStyle = .short
            let data = Date()
            print(dataFormater.string(from: data))
            print(#line,"Temperature: ",decoderWeather!.main.temp!)
        }
    }.resume()
    }
}
