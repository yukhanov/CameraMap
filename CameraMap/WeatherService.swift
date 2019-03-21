//
//  WeatherService.swift
//  WorldCameras
//
//  Created by Юханов Сергей Сергеевич on 05/02/2019.
//  Copyright © 2019 Юханов Сергей Сергеевич. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class WeatherService {
    
    static var weatherList: [WeatherData] = [] {
    
        didSet {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "send"), object: nil)
        }
    }
    
    static var cameraCityList: [CameraCity] = [] {
        
        didSet {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "sendCamera"), object: nil)
        }
    }
    
    
    static func getWeatherData(city: String) {
        
        print("Start")
        
        let weatherUrl = "https://api.openweathermap.org/data/2.5/weather"
        let params: Parameters = ["q": city, "appid": "02a082f1be3fb9bbf041f849ca8ad290", "units": "metric"]
        
        request(weatherUrl, method: .get, parameters: params).responseJSON(queue: DispatchQueue.global()) { (response) in
            print("Stage2")
            if response.result.isSuccess {
                let weatherJSON: JSON = JSON(response.result.value!)
//                print(weatherJSON)
//                let temp: Int = weatherJSON["main"]["temp"].intValue
                //print(weatherJSON)
                let weatherData: WeatherData = WeatherData(json: weatherJSON)
                
                WeatherService.weatherList.append(weatherData)
                print("wewfewfwefwef")
                print(weatherData.name)
                
                //NotificationCenter.default.post(name: NSNotification.Name(rawValue: "send"), object: weatherData.temp)
                
            } else {
                print("Error \(String(describing: response.result.error?.localizedDescription))")
            }
        }
        
        
    }
    
    static func getWeatherFromName(city: String) -> WeatherData? {
        for value in WeatherService.weatherList {
            if value.name == city {
        
                return value
                
            }
        }
        return nil
    }
    


}
