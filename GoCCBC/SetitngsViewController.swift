//
//  SetitngsViewController.swift
//  GoCCBC
//
//  Created by Ernest Essuah Mensah on 4/11/17.
//  Copyright © 2017 Ernest Essuah Mensah. All rights reserved.
//

import UIKit
import Firebase

class SetitngsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let options: [String] = ["Change Major", "Change Userame", "Change Profile Image", "Logout"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return options.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "settingCell")! as UITableViewCell
        cell.textLabel!.text = options[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
        switch indexPath.row
        {
            
        case 0:
            self.performSegue(withIdentifier: "toChangeMajorScreen", sender: nil)
            
        case 1:
            self.performSegue(withIdentifier: "toUpdateNameScreen", sender: nil)
            
        case 2:
            self.performSegue(withIdentifier: "toProfileImage", sender: nil)
            
        case 3:
            let alertController = UIAlertController(title: "Logout?", message: "You are about to be logged out", preferredStyle: .alert)
            let OkAction = UIAlertAction(title: "Continue", style: .destructive) { (action:UIAlertAction!) in
                
                do {
                    try FIRAuth.auth()?.signOut()
                }
                catch let logoutError {
                    print(logoutError)
                }
                
                self.performSegue(withIdentifier: "toLoginScreen", sender: nil)
            }
            alertController.addAction(OkAction)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true, completion: nil)
            
        default:
            print("The fuck?")
            
        }
        
    }
    
}
