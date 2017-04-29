//
//  ChallengeVC.swift
//  GoCCBC
//
//  Created by Ernest Essuah Mensah on 4/19/17.
//  Copyright © 2017 Ernest Essuah Mensah. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ChallengeVC: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var waitView: UIView!
    @IBOutlet weak var distanceView: UIView!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var destinationLabel: UILabel!
    
    let locMan: CLLocationManager = CLLocationManager()
    
    let kCupertinoLatitude: CLLocationDegrees = 39.253170
    let kCupertinoLongitude: CLLocationDegrees = -76.732861
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let newLocation: CLLocation=locations[0]
        NSLog("Something is happening")
        if newLocation.horizontalAccuracy >= 0 {
            
            let Cupertino:CLLocation = CLLocation(latitude: kCupertinoLatitude, longitude: kCupertinoLongitude)
            let delta:CLLocationDistance = Cupertino.distance(from: newLocation)
            let miles: Double = (delta * 0.000621371) + 0.5 // meters to rounded miles
            if miles < 0.05 {
                // Stop updating the location
                locMan.stopUpdatingLocation()
                // Congratulate the user
                distanceLabel.text = "My nigaaaaaa!"
            } else {
                let commaDelimited: NumberFormatter = NumberFormatter()
                commaDelimited.numberStyle = NumberFormatter.Style.decimal
                distanceLabel.text=commaDelimited.string(from: NSNumber(value:miles))! + " miles"
            }
//            waitView.isHidden = true
//            distanceView.isHidden = false
        }
        // oldLocation=locations[0] as CLLocation
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        if error._code == CLError.denied.rawValue {
            locMan.stopUpdatingLocation()
        } else {
//            waitView.isHidden = true
//            distanceView.isHidden = false
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        locMan.delegate = self
        locMan.desiredAccuracy = kCLLocationAccuracyBest
        //locMan.distanceFilter = 1609; // a mile
        locMan.requestWhenInUseAuthorization()
        locMan.startUpdatingLocation()
        locMan.pausesLocationUpdatesAutomatically = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        destinationLabel.text = (presentingViewController as! ChallengeScreenVC).mapLabel.text
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }


}
