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
        marker.position = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let label = UILabel()
        label.text = " latitude & longitude \n \(Double(latitude).rounded(toPlaces: 5)), \(Double(longitude).rounded(toPlaces: 5)) "
        label.numberOfLines = 2
        label.backgroundColor = .white
        label.layer.cornerRadius = 12
        label.layer.borderWidth = 0.5
        label.layer.borderColor = UIColor.black.cgColor
        label.layer.masksToBounds = true
        label.sizeToFit()
        marker.iconView = label
        marker.map = mapView
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
            camera = GMSCameraPosition.camera(withLatitude: locValue.latitude,
                                                  longitude: locValue.longitude,
                                                  zoom: 12)

            mapView = GMSMapView.map(withFrame: .zero, camera: camera)
            mapView.delegate = self
            self.view = mapView
            addMarker(latitude: locValue.latitude, longitude: locValue.longitude)
        }
    }
}
extension GoogleMapsViewController{
    
   func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
    self.mapView.clear()
    self.addMarker(latitude: coordinate.latitude, longitude: coordinate.longitude)
      print("You tapped at \(coordinate.latitude), \(coordinate.longitude)")

    }
}
