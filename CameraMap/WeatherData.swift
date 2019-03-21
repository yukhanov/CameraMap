//
//  WeatherData.swift
//  WorldCameras
//
//  Created by Юханов Сергей Сергеевич on 06/02/2019.
//  Copyright © 2019 Юханов Сергей Сергеевич. All rights reserved.
//

import Foundation
import SwiftyJSON

class WeatherData {
    var temp: Int
    var name: String
    var latitude: String
    var longitude: String

    
    init(json: JSON) {
        self.temp = json["main"]["temp"].intValue
        self.name = json["name"].stringValue
        self.latitude = json["coord"]["lat"].stringValue
        self.longitude = json["coord"]["lon"].stringValue
    }
    
    
}
