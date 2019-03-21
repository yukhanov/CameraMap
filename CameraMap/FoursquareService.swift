//
//  FoursquareService.swift
//  WorldCameras
//
//  Created by Юханов Сергей Сергеевич on 14/02/2019.
//  Copyright © 2019 Юханов Сергей Сергеевич. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


class FoursquareService {
    
    static var namesList = [String: Any]()
    static var arrayOfVenues: [String: Any] = [:]
    
    static func getVenuesFromLocation(location: String) {
        
        let foursquareUrl: String = "https://api.foursquare.com/v2/venues/search"
        let params: Parameters = ["client_id": "BWVHCDSDRPEFJUVILRT0WE2TSKVQVR1WY0CGXQFQBVCU2BYG", "client_secret": "RVQ0FVVQOB0D1KVTGE3OOQS3VNJ2G1CFS0ISYOOECLN1GDH5", "ll": location, "limit": "10", "v": "20190214"]
        
        request(foursquareUrl, method: .get, parameters: params).responseJSON(queue: DispatchQueue.global()) { (response) in
            if response.result.isSuccess {
                let foursquareJSON: JSON = JSON(response.result.value!)
                
                for (_, valuesJSON) in foursquareJSON["response"]["venues"] {
                    
                    FoursquareService.namesList["title"] = valuesJSON["name"].stringValue
                    FoursquareService.namesList["latitude"] = valuesJSON["location"]["lat"].doubleValue
                    FoursquareService.namesList["longitude"] = valuesJSON["location"]["lng"].doubleValue
                    
                    FoursquareService.arrayOfVenues = namesList
                
                    
                }
                print(arrayOfVenues)
                
            } else {
                print("Error \(String(describing: response.result.error))")
            }
        }
        
    }
    

    

}
