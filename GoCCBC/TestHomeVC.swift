//
//  TestHomeVC.swift
//  GoCCBC
//
//  Created by Ernest Essuah Mensah on 4/29/17.
//  Copyright © 2017 Ernest Essuah Mensah. All rights reserved.
//

import UIKit

//Test class for constraints
class TestHomeVC: UIViewController {

    @IBOutlet weak var scroller: UIScrollView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scroller.contentSize = CGSize(width: 0.0, height: 500.0)

        // Do any additional setup after loading the view.
    }

}
