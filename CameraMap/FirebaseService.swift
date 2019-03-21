//
//  FirebaseService.swift
//  WorldCameras
//
//  Created by Юханов Сергей Сергеевич on 13/03/2019.
//  Copyright © 2019 Юханов Сергей Сергеевич. All rights reserved.
//

import Foundation
import Firebase
import SwiftyJSON

class FirebaseService {
    static var cameraData: [FirebaseData] = []
    static var camerasJSON: JSON = []
    
    
    static func getCameraData() {
        FirebaseApp.configure()
        
        let db = Firestore.firestore()
        db.collection("cameras").getDocuments(completion: { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
            for document in querySnapshot!.documents {
               
                FirebaseService.camerasJSON = JSON(document.data())
                //FirebaseService.cameras.append(document.data())
                print(FirebaseService.camerasJSON)
                
                let camData: FirebaseData = FirebaseData(json: camerasJSON)
                
                FirebaseService.cameraData.append(camData)
                print(cameraData)
                
                
                }
            
            }
        
        })
   
    }
}
