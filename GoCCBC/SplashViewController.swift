//
//  SplashViewController.swift
//  GoCCBC
//
//  Created by Ernest Essuah Mensah on 5/1/17.
//  Copyright © 2017 Ernest Essuah Mensah. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Displays the view for 3 seconds and transitions to the next screen
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(4), execute: {
            self.performSegue(withIdentifier: "toInitialScreen", sender: nil)
        })

    }

    

}
