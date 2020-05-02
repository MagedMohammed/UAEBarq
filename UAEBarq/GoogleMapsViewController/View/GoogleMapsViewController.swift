//
//  GoogleMapsViewController.swift
//  UAEBarq
//
//  Created by Maged Omar on 5/2/20.
//  Copyright © 2020 Maged Omar. All rights reserved.
//

import UIKit
import CoreLocation
import GoogleMaps


class GoogleMapsViewController: UIViewController, GMSMapViewDelegate{
    //    MARK:- Outlet
    
    
    //    MARK:- Properties
    var locationManager: CLLocationManager!
    var latitude:Double!
    var longitude:Double!
    var camera = GMSCameraPosition()
    var mapView = GMSMapView()
    
    //    MARK:- ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Google Maps"
        // LocationManger Properties
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 200
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        self.mapView.delegate = self
        
    }
    func addMarker(latitude: Double, longitude: Double){
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude)
        marker.title = "latitude & longitude"
        marker.snippet = "\(latitude),\(longitude)"
        marker.map = mapView
    }
}

extension GoogleMapsViewController:CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("location error is = \(error.localizedDescription)")
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let locValue:CLLocationCoordinate2D = (manager.location?.coordinate){
            print("Current Locations = \(locValue.latitude) \(locValue.longitude)")
            self.latitude = Double(locValue.latitude)
            self.longitude = Double(locValue.longitude)
            self.camera = GMSCameraPosition.camera(withLatitude: self.latitude, longitude: self.longitude, zoom: 15.0)
            self.mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
            self.view.addSubview(mapView)
            // Creates a marker in the center of the map.
            addMarker(latitude: self.latitude, longitude: self.longitude)
        }
    }
}
extension GoogleMapsViewController{
    
   func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
      print("You tapped at \(coordinate.latitude), \(coordinate.longitude)")
        self.mapView.clear()
        self.addMarker(latitude: Double(coordinate.latitude), longitude: Double(coordinate.longitude))

    }
    
}
