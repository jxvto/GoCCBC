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
import Firebase

class ChallengeVC: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var waitView: UIView!
    @IBOutlet weak var distanceView: UIView!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var destinationLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    
    
    //MARK: - Properties
    var seconds = 0
    var timer = Timer()
    var isTimerRunning = false
    var resumeTapped = false
    
    let locMan: CLLocationManager = CLLocationManager()
    
    
    var startLocation: CLLocation!
    var lastLocation: CLLocation!
    var startDate: Date!
    var traveledDistance: Double = 0
    
    let kCupertinoLatitude: CLLocationDegrees = 39.253170
    let kCupertinoLongitude: CLLocationDegrees = -76.732861
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations[0]
        
        let space:MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)
        let myLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        let region:MKCoordinateRegion = MKCoordinateRegionMake(myLocation, space)
        mapView.setRegion(region, animated: true)
    
        self.mapView.showsUserLocation = true
        
        //print(locations.last ?? "none")
        if startDate == nil {
            startDate = Date()
        } else {
//            print("elapsedTime:", String(format: "%.0fs", Date().timeIntervalSince(startDate)))
            //timeLabel.text = String(format: "%.0fs", Date().timeIntervalSince(startDate))
        }
        
        if startLocation == nil {
            startLocation = locations.first
        } else if let location = locations.last {
            traveledDistance += lastLocation.distance(from: location)
//            print("Traveled Distance:",  Int(traveledDistance))
//            print("Straight Distance:", startLocation.distance(from: locations.last!))
            distanceLabel.text = String(format: "%.2f", traveledDistance) + " meters"
    
        }
        lastLocation = locations.last
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
        
        locMan.delegate = self
        locMan.desiredAccuracy = kCLLocationAccuracyBest
        locMan.requestWhenInUseAuthorization()
        locMan.startUpdatingLocation()
        
        locMan.startMonitoringSignificantLocationChanges()
        locMan.distanceFilter = 10
        mapView.userTrackingMode = .follow
        
        distanceLabel.isHidden = true
        
        startButton.layer.cornerRadius = 10
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        destinationLabel.text = (presentingViewController as! ChallengeScreenVC).mapLabel.text
    }
    
    
    @IBAction func donePressed(_ sender: Any) {
        
        let timeElapsed: Double?
        let distance: Double?
        
        distance = traveledDistance.roundTo(places: 2)
        timeElapsed = (TimeInterval(seconds) / 60).roundTo(places: 2)
        
        let alertController = UIAlertController(title: "Successfully Updated", message: "Your stats have been posted to your profile.", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil)
        alertController.addAction(defaultAction)
        self.present(alertController, animated: true, completion: nil)
        
        
        guard let uid = FIRAuth.auth()?.currentUser?.uid else {
            return
        }
        
        let ref = FIRDatabase.database().reference(fromURL: "https://goccbc.firebaseio.com/")
        let usersReference = ref.child("leaderboard").child(uid)
        
        if let time = timeElapsed, let dist = distance
        {
            
            let values = ["time": time, "distance": dist]
            usersReference.updateChildValues(values, withCompletionBlock: { (err, ref) in
                
                if err != nil{
                    print(err!)
                    return
                }
            })
        }
    }
    
    
    
    

    
//  Timer
//  Created by Jennifer A Sipila on 12/2/16.
//  Copyright © 2016 Jennifer A Sipila. All rights reserved.
//
    
   
    @IBAction func startTapped(_ sender: Any) {
        
        distanceLabel.isHidden = false
        
        if isTimerRunning == false {
            
            runTimer()
            self.startButton.setTitle("Pause", for: .normal)
        } else
            if isTimerRunning == true {
            timer.invalidate()
            self.startButton.setTitle("Resume", for: .normal)
                isTimerRunning = false
        }
    }
    
    
    @IBAction func resetTapped(_ sender: Any) {
        
        timer.invalidate()
        seconds = 0
        timeLabel.text = timeString(time: TimeInterval(seconds))
        isTimerRunning = false
        runTimer()
    }
    
    //MARK: - Public Method
    func updateTimer(){
        
        seconds += 1
        timeLabel.text = timeString(time: TimeInterval(seconds))
    }
    
    func timeString(time:TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
    }
    
    
    func runTimer() {
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
        isTimerRunning = true
        
    }
    
    


}
