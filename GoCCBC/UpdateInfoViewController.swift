//
//  UpdateInfoViewController.swift
//  GoCCBC
//
//  Created by Ernest Essuah Mensah on 4/12/17.
//  Copyright © 2017 Ernest Essuah Mensah. All rights reserved.
//

import UIKit
import Firebase

class UpdateInfoViewController: UIViewController {
    @IBOutlet weak var majorTextfield: UITextField!
    @IBOutlet weak var majorLabel: UILabel!
    @IBOutlet weak var updateButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        updateButton.layer.cornerRadius = 5
        updateButton.isHidden = true
        getUserMajor()
    
    }

    // Updates the user's major child node in the Firebase database
    @IBAction func updateMajor(_ sender: Any) {
        majorLabel.text = majorTextfield.text
        
        guard let uid = FIRAuth.auth()?.currentUser?.uid else {
            return
        }
        
        let ref = FIRDatabase.database().reference(fromURL: "https://goccbc.firebaseio.com/")
        let usersReference = ref.child("users").child(uid)
        
        if let major = majorTextfield.text
        {
            
            let values = ["major": major]
            usersReference.updateChildValues(values, withCompletionBlock: { (err, ref) in
                
                if err != nil{
                    print(err!)
                    return
                }
            })
        }
    }
    
    // Returns and displays the user's major from the Firebase database.
    func getUserMajor() {
        guard let uid = FIRAuth.auth()?.currentUser?.uid else {
            return
        }
        
        FIRDatabase.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                self.majorLabel.text = dictionary["major"] as? String
            }
        }, withCancel: nil)
    }
    

    
    @IBAction func hideKeyboard(_ sender: Any) {
        
        majorTextfield.resignFirstResponder()
        updateButton.isHidden = false
        
    }
    
    
}
