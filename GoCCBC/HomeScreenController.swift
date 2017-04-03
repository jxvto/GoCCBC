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

    @IBOutlet weak var logoutButton: UIButton!
    
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

        
    }

   
    func checkIfUserLoggedIn () {
        if FIRAuth.auth()?.currentUser?.uid == nil {
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
        } else {
            //fetchUserAndSetupNavBarTitle()
        }
    }
    
//    @IBAction func handleLogout(_ sender: Any) {
//        do {
//            try FIRAuth.auth()?.signOut()
//        }
//        catch let logoutError {
//            print(logoutError)
//        }
//        
//        let loginController = LoginController()
//        //loginController.homeController = self
//        present(loginController, animated: true, completion: nil)
//    }
//    
    
}
