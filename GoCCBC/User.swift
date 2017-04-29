//
//  User.swift
//  chat_App
//
//  Created by Ernest Essuah Mensah on 3/24/17.
//  Copyright © 2017 Ernest Essuah Mensah. All rights reserved.
//

import UIKit

class User: NSObject {

    var name: String?
    var email: String?
    var profileImageUrl: String?
    var gender: String?
    var major: String?
    var caloriesBurnt: Double?
    var time: Double?
    var distance: Double?
    
    func setupStats(name: String, time: Double, distance: Double, calorieCount: Double) {
        
        self.name = name
        self.time = time
        self.distance = distance
        self.caloriesBurnt = calorieCount
        
    }

}
