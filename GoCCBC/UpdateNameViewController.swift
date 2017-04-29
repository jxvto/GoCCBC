//
//  UpdateNameViewController.swift
//  GoCCBC
//
//  Created by Ernest Essuah Mensah on 4/13/17.
//  Copyright © 2017 Ernest Essuah Mensah. All rights reserved.
//

import UIKit
import Firebase

class UpdateNameViewController: UIViewController {

    @IBOutlet weak var nameTextfield: UITextField!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var timeTextfield: UITextField!
    @IBOutlet weak var distanceTextfield: UITextField!
    @IBOutlet weak var calTextfield: UITextField!
    
    
    @IBAction func updateStats(_ sender: Any) {
        
        guard let uid = FIRAuth.auth()?.currentUser?.uid else {
            return
        }
        
        let ref = FIRDatabase.database().reference(fromURL: "https://goccbc.firebaseio.com/")
        let usersReference = ref.child("leaderboard").child(uid)
        
        if let time = Double(timeTextfield.text!), let dist = Double(distanceTextfield.text!), let cal = Double(calTextfield.text!)
        {
            
            let values = ["time": time, "distance": dist, "caloriesBurnt": cal]
            usersReference.updateChildValues(values, withCompletionBlock: { (err, ref) in
                
                if err != nil{
                    print(err!)
                    return
                }
            })
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        doneButton.layer.cornerRadius = 5
        getUserName()

    }

    @IBAction func updateName(_ sender: Any) {
        nameLabel.text = nameTextfield.text
        
        guard let uid = FIRAuth.auth()?.currentUser?.uid else {
            return
        }
        
        let ref = FIRDatabase.database().reference(fromURL: "https://goccbc.firebaseio.com/")
        let usersReference = ref.child("users").child(uid)
        
        if let name = nameTextfield.text
        {
            
            let values = ["name": name]
            usersReference.updateChildValues(values, withCompletionBlock: { (err, ref) in
                
                if err != nil{
                    print(err!)
                    return
                }
            })
        }
        
        
    }

    
    @IBAction func hideKeyboard(_ sender: Any) {
        nameTextfield.resignFirstResponder()
        distanceTextfield.resignFirstResponder()
        calTextfield.resignFirstResponder()
        timeTextfield.resignFirstResponder()
    }
    
    
    
    
    func getUserName() {
        guard let uid = FIRAuth.auth()?.currentUser?.uid else {
            return
        }
        
        FIRDatabase.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
            self.nameLabel.text = dictionary["name"] as? String
            }
        }, withCancel: nil)
    }
    
}
