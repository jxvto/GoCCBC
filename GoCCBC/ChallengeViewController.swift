//
//  ChallengeViewController.swift
//  GoCCBC
//
//  Created by Ernest Essuah Mensah on 4/19/17.
//  Copyright © 2017 Ernest Essuah Mensah. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

// Tinkering with this class for implementation of the challenge mode

class ChallengeViewController: UIViewController, CLLocationManagerDelegate {

    let coreLocationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var userLocation: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        coreLocationManager.delegate = self
        
        coreLocationManager.desiredAccuracy = kCLLocationAccuracyBest
        coreLocationManager.requestWhenInUseAuthorization()
        coreLocationManager.stopMonitoringSignificantLocationChanges()
        
    }
    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        
//        let location = locations[0]
//        
//        let span: MKCoordinateSpan = MKCoordinateSpanMake(0.1, 0.1)
//        let myLocation = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.latitude)
//        let region = MKCoordinateRegionMake(myLocation, span)
//        
//        mapView.setRegion(region, animated: true)
//        
//        self.mapView.showsUserLocation = true
//    }
    
    func locationAuthStatus() {
        
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse
        {
            currentLocation = coreLocationManager.location
            print("Latitude: \(currentLocation.coordinate.latitude), Longitude: \(currentLocation.coordinate.longitude)")
//            let userLocation = CLLocationCoordinate2DMake(currentLocation.coordinate.latitude, currentLocation.coordinate.latitude)
//            let span: MKCoordinateSpan = MKCoordinateSpanMake(0.05, 0.05)
//            let region = MKCoordinateRegionMake(userLocation, span)
//            
//            mapView.setRegion(region, animated: true)
//            self.mapView.showsUserLocation = true
            
        }
        else
        {
            coreLocationManager.requestWhenInUseAuthorization()
            locationAuthStatus()
        }
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        locationAuthStatus()
    }

    
    @IBAction func updateLocation(_ sender: Any) {
        
        
    }
    
    

}





