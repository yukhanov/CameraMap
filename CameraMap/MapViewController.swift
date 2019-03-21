//
//  MapViewController.swift
//  WorldCameras
//
//  Created by Юханов Сергей Сергеевич on 06/02/2019.
//  Copyright © 2019 Юханов Сергей Сергеевич. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    
    var city: String = "" 
    
    
    var mapView: MKMapView = MKMapView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let lon: Double = Double(WeatherService.getWeatherFromName(city: city)!.longitude)!
//        let lat: Double = Double(WeatherService.getWeatherFromName(city: city)!.latitude)!
        let lat: Double = 55.45
        let lon: Double = 37.36
        
        mapView.bounds = view.bounds
        mapView.frame.origin.x = 0
        mapView.frame.origin.y = 0
        view.addSubview(mapView)

        mapView.delegate = self
        let geocoder = CLGeocoder()
        let location = CLLocation(latitude: lat, longitude: lon)
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            guard error == nil else { return }
            guard let placemarks = placemarks else { return }

            let placemark = placemarks.first
            let annotation = MKPointAnnotation()

            annotation.title = self.city

            guard let location = placemark?.location else { return }
            annotation.coordinate = location.coordinate

            self.mapView.showAnnotations([annotation], animated: true)
            self.mapView.selectAnnotation(annotation, animated: true)
        
            //self.createAnnotations(locations: [FoursquareService.arrayOfVenues])
        }
        
            FoursquareService.getVenuesFromLocation(location: locationDoubleToString(longitude: lon, latitude: lat))
       
        
        
    }
    
    func locationDoubleToString(longitude: Double, latitude: Double) -> String {
        
        let lonStr = String(longitude)
        let latStr = String(latitude)
        return (latStr + "," + lonStr)
        
    }
    
    func createAnnotations(locations: [[String: Any]]) {
        for location in locations {
            let annotations = MKPointAnnotation()
            annotations.title = location["title"] as? String
            annotations.coordinate = CLLocationCoordinate2D(latitude: location["latitude"] as! CLLocationDegrees, longitude: location["longitude"] as! CLLocationDegrees)
            mapView.addAnnotation(annotations)
            
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
        return annotationView
    }



}
