//
//  CustomTableViewCell.swift
//  GoCCBC
//
//  Created by Ernest Essuah Mensah on 4/19/17.
//  Copyright © 2017 Ernest Essuah Mensah. All rights reserved.
//

import UIKit


// No need for this class
class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    func setLabels(name: String, time: String, distance: String) {
        
        self.nameLabel?.text = name
        self.timeLabel?.text = time
        self.distanceLabel?.text = distance
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
