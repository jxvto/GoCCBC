//
//  ChallengeScreenVC.swift
//  GoCCBC
//
//  Created by Ernest Essuah Mensah on 4/24/17.
//  Copyright © 2017 Ernest Essuah Mensah. All rights reserved.
//

import UIKit

class ChallengeScreenVC: UIViewController {
    
    @IBOutlet weak var mapLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var beginButton: UIButton!
    @IBOutlet weak var distanceLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        beginButton.layer.cornerRadius = 10

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        imageView.image = (presentingViewController as! MapViewController).imageView.image
        mapLabel.text = (presentingViewController as! MapViewController).selectedMap.text
        distanceLabel.text = (presentingViewController as! MapViewController).distanceLabel.text
    }


}
