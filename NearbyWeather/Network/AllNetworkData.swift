//
//  AllNetworkData.swift
//  NearbyWeather
//
//  Created by Aleksandr Gazizov on 13/08/2019.
//  Copyright © 2019 orik. All rights reserved.
//
import Foundation

class AllNetworkData {
    private init() {  }
    static let shared: AllNetworkData = AllNetworkData()
    
    
    func getWeatherInfo(lat: Double, lon: Double, result: @escaping ((MainAllWeather) -> ())) {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.openweathermap.org"
        urlComponents.path = "/data/2.5/forecast"
        urlComponents.queryItems = [URLQueryItem(name: "lat", value: String(lat)),
                                    URLQueryItem(name: "lon", value: String(lon)),
                                    URLQueryItem(name: "units", value: "metric"),
                                    URLQueryItem(name: "appid", value: "57c7cb446dbc8918541b6ce92073239e")]
        
        var request = URLRequest(url: urlComponents.url!)
        
        request.httpMethod = "GET"
        let task = URLSession(configuration: .default)
        
        task.dataTask(with: request) { (data, response, error) in
            guard error == nil else { return }
            var decoderAllWeather: MainAllWeather?
            
            if data != nil {
                decoderAllWeather = try? JSONDecoder().decode(MainAllWeather.self, from: data!)
                result(decoderAllWeather!)
                
            }
            }.resume()
    }
}
