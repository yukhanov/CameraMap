//
//  CameraMapViewController.swift
//  WorldCameras
//
//  Created by Юханов Сергей Сергеевич on 05/03/2019.
//  Copyright © 2019 Юханов Сергей Сергеевич. All rights reserved.
//

import UIKit
import MapKit
import Firebase

class CameraMapViewController: UIViewController, MKMapViewDelegate {
    

    
    var mapView: MKMapView = MKMapView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        

        mapView.bounds = view.bounds
        mapView.frame.origin.x = 0
        mapView.frame.origin.y = 0
        view.addSubview(mapView)

        
        

        mapView.delegate = self
        
        FirebaseService.getCameraData()
        print("viewDidLoad")
        
        NotificationCenter.default.addObserver(self, selector: #selector(send_object2), name: NSNotification.Name(rawValue: "sendCamera"), object: nil)
        
        
    }
    
    @objc func send_object2(_ status: Notification) {
        
        DispatchQueue.main.async {
            print("Notification")
            
            self.createAnnotations()
        }
        
        
    }
  
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else { return nil }
        let annotationIdentifier = "restAnnotation"
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier) as? MKPinAnnotationView
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
            annotationView?.canShowCallout = true
        }
        
        annotationView?.pinTintColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        annotationView?.canShowCallout = false
        let showUserProfileGester = UITapGestureRecognizer()
        showUserProfileGester.addTarget(self, action:  #selector(showUserProfileMethod))
        annotationView?.addGestureRecognizer(showUserProfileGester)
        return annotationView
    }
    
    @objc func showUserProfileMethod(sender: UITapGestureRecognizer) {
        let pin = sender.view as? MKAnnotationView
        
        let detailVC: DetailViewController = DetailViewController()
        detailVC.currentCity = pin!.annotation!.title as! String
        present(detailVC, animated: true, completion: nil)
      //  if let annotationView = (sender.view as? MKAnnotationView)?.annotation as? CustomPointAnnotation  {
            //performSegue(withIdentifier: "goDetail", sender: pin?.annotation?.title)
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let invaitPlaceViewController = storyboard.instantiateViewController(withIdentifier: "InvaitPlaceViewController") as! InvaitPlaceViewController
//            invaitPlaceViewController.userID = annotationView.pointId
//            present(invaitPlaceViewController, animated: true, completion: nil)
       // }
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "goDetail", let cityName = sender as? String {
//            let detailVC: DetailViewController = segue.destination as! DetailViewController
//
//
//
//        }
//    }

    func createAnnotations() {
        for camera in FirebaseService.cameraData {
            let annotations = MKPointAnnotation()
            annotations.title = camera.name
            print(camera.name)
            annotations.coordinate = CLLocationCoordinate2D(latitude: camera.lat , longitude: camera.lon )
            mapView.addAnnotation(annotations)
            
        }
    }
    


}
