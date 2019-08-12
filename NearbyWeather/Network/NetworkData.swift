//
//  NetworkData.swift
//  NearbyWeather
//
//  Created by orik on 12/08/2019.
//  Copyright © 2019 orik. All rights reserved.
//
import Foundation
//import UIKit

func getWeatherInfo(lat: Double, lon: Double) {

    var urlComponents = URLComponents()
    urlComponents.scheme = "https"
    urlComponents.host = "api.openweathermap.org"
    urlComponents.path = "data/2.5/weather"
    urlComponents.queryItems = [URLQueryItem(name: "lat", value: String(lat)),
                                URLQueryItem(name: "lon", value: String(lon)),
                                URLQueryItem(name: "appid", value: "57c7cb446dbc8918541b6ce92073239e")
                                ]
     print(urlComponents)
    print(urlComponents.url!.absoluteString)
    if urlComponents.url !=  nil {
        print(urlComponents.url!)
    var request = URLRequest(url: urlComponents.url!)
   
    request.httpMethod = "GET"
    let task = URLSession(configuration: .default)
   
    task.dataTask(with: request) { (data, response, error) in
        guard error == nil else { return }
        var decoderWeather: mainWeather?
        
        if data != nil {
            decoderWeather = try? JSONDecoder().decode(mainWeather.self, from: data!)
            
        }
        print(decoderWeather!)
    }
    }
}
