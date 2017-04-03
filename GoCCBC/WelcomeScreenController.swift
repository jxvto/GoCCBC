//
//  WelcomeScreenController.swift
//  GoCCBC
//
//  Created by Ernest Essuah Mensah on 3/31/17.
//  Copyright © 2017 Ernest Essuah Mensah. All rights reserved.
//

import UIKit

class WelcomeScreenController: UIViewController {
    
    @IBOutlet weak var welcomeLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Displays the view for 3 seconds and transitions to the next screen
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3), execute: {
            self.performSegue(withIdentifier: "toHome", sender: nil)
        })

        
    }
    
    // Displays the user's name with a welcome greeting
    override func viewWillAppear(_ animated: Bool) {
        
        welcomeLabel.text = " Hello, " + (presentingViewController as! ViewController).nameLabel.text!
    }


}
