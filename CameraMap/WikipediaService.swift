//
//  WikipediaService.swift
//  WorldCameras
//
//  Created by Юханов Сергей Сергеевич on 06/02/2019.
//  Copyright © 2019 Юханов Сергей Сергеевич. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class WikipediaService {
    
    func getDataFromWiki(search: String) {
        let wikiURL: String = "https://ru.wikipedia.org/w/api.php?action=query&api.php?action=query&prop=revisions&rvprop=content&redirects=1&format=json"
        let params: Parameters = ["titles": search]
        
        request(wikiURL, method: .get, parameters: params).responseJSON(queue: DispatchQueue.global()) { (response) in
            if response.result.isSuccess {
               
                let wikiJSON: JSON = JSON(response.result.value!)
                print(wikiJSON)
                //let temp: Int = weatherJSON["main"]["temp"].intValue
                //temp.dropLast(2)
                
                //NotificationCenter.default.post(name: NSNotification.Name(rawValue: "send"), object: temp)
                
            } else {
                print("Error \(String(describing: response.result.error))")
            }
        }
    }
}
