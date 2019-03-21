//
//  FirebaseData.swift
//  WorldCameras
//
//  Created by Юханов Сергей Сергеевич on 13/03/2019.
//  Copyright © 2019 Юханов Сергей Сергеевич. All rights reserved.
//

import Foundation
import SwiftyJSON

class FirebaseData {
    var name: String
    var lat: Double
    var lon: Double
    var url: String
    
    init(json: JSON) {
        self.name = json["name"].stringValue
        self.lat = json["lat"].doubleValue
        self.lon = json["lon"].doubleValue
        self.url = json["cameraURL"].stringValue
    }
}
