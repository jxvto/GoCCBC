//
//  HomeScreenController.swift
//  GoCCBC
//
//  Created by Ernest Essuah Mensah on 4/2/17.
//  Copyright © 2017 Ernest Essuah Mensah. All rights reserved.
//

import UIKit
import Firebase

class HomeScreenController: UIViewController {

    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var majorLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var challengeButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var calLabel: UILabel!
    
    
    
    var users = [User]()
    
    var userNameLabel: String = ""
    var usermajor: String = ""
    var userEmail: String = ""
    
    
    
    @IBAction func handleLogout(_ sender: Any) {
        do {
            try FIRAuth.auth()?.signOut()
        }
        catch let logoutError {
            print(logoutError)
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImageView?.layer.cornerRadius = self.profileImageView.frame.width / 2
        profileImageView?.clipsToBounds = true
        checkIfUserLoggedIn()
    }
    
    func fetchUserAndSetupNavBarTitle() {
        
        guard let uid = FIRAuth.auth()?.currentUser?.uid else {
            return
        }
        
        FIRDatabase.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                self.welcomeLabel.text = "Welcome, \(String(describing: dictionary["name"] as! String))"
                
                self.userName.text = dictionary["name"] as? String
                self.majorLabel.text = dictionary["major"] as? String
                self.emailLabel.text = dictionary["email"] as? String
                
                let user = User()
                user.setValuesForKeys(dictionary)
                self.setupUserProfileImage(user: user)
                
            }
        }, withCancel: nil)
        
        
        FIRDatabase.database().reference().child("leaderboard").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                
                let distance = String(describing: dictionary["distance"]!)
                let time = String(describing: dictionary["time"]!)
                //let calories = String(describing: dictionary["caloriesBurnt"]!)
                
                self.distanceLabel.text = distance
                self.timeLabel.text = time
                //self.calLabel.text = calories
            }
        }, withCancel: nil)
        
        
    }
    
    func setupUserInfo() {
        
        userName.text = userNameLabel
        emailLabel.text = userEmail
        majorLabel.text = usermajor
        welcomeLabel.text = "Welcome, \(userNameLabel)"
        
        print(userNameLabel, usermajor, userEmail)
    }
    
    
    func setupUserProfileImage(user: User)
    {
        if let profileImageUrl = user.profileImageUrl {
            profileImageView.loadImageUsingCacheWithUrlString(profileImageUrl)
        }
    }
    

   
    func checkIfUserLoggedIn () {
        if FIRAuth.auth()?.currentUser?.uid == nil {
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
        } else {
            fetchUserAndSetupNavBarTitle()
        }
    }
    
    
    
}
