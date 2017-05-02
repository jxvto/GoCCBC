//
//  LeaderboardViewController.swift
//  GoCCBC
//
//  Created by Ernest Essuah Mensah on 4/24/17.
//  Copyright © 2017 Ernest Essuah Mensah. All rights reserved.
//

import UIKit
import Firebase

class LeaderboardViewController: UITableViewController {
    
    var users = [User]()
    var count = 0
    var distances = [Double]()
    let cellID = "CellID"

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchUser()

        tableView.register(LeaderboardCell.self, forCellReuseIdentifier: cellID)
        
        updateLeaderboard()
        

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    func fetchUser()
    {
        FIRDatabase.database().reference().child("leaderboard").observe(.childAdded, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject]
            {
                let user = User()
                
                user.setupStats(name: dictionary["name"]! as! String, time: dictionary["time"]! as! Double, distance: dictionary["distance"]! as! Double, calorieCount: dictionary["caloriesBurnt"]! as! Double)
                
                self.users.append(user)
                
                DispatchQueue.main.async
                {
                    self.tableView.reloadData()
                }
            }
            
        }, withCancel: nil)
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return users.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! LeaderboardCell
        
        let user = users[indexPath.row]
        
        cell.timeLabel.text = String(describing: user.time!) + " min"
        cell.nameLabel.text = String(describing: user.name!)
        cell.distanceLabel.text = String(describing: user.distance!) + " m"
        //cell.calorieLabel.text = String(describing: user.caloriesBurnt!) + " cal"
        
        return cell
        
    }
    
    
    @IBAction func displayCount(_ sender: Any) {
        
        print("Users:" , count)
    }
    
    
    
    func updateLeaderboard() {
        
        guard let uid = FIRAuth.auth()?.currentUser?.uid else {
            return
        }
        
        let ref = FIRDatabase.database().reference(fromURL: "https://goccbc.firebaseio.com/")
        let usersReference = ref.child("leaderboard").child(uid)
        
        let usersTopDistanceQuery = (usersReference.child("distance").queryOrderedByValue())
        
        
        
    }

}


class LeaderboardCell: UITableViewCell {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        textLabel?.frame = CGRect(x: 64, y: textLabel!.frame.origin.y - 2, width: textLabel!.frame.width, height: textLabel!.frame.height)
        
        detailTextLabel?.frame = CGRect(x: 64, y: detailTextLabel!.frame.origin.y + 2, width: detailTextLabel!.frame.width, height: detailTextLabel!.frame.height)
    }
    
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = label.font.withSize(12)
        
        return label
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(colorLiteralRed: 202/255, green: 125/225, blue: 124/255, alpha: 1)
        label.font = label.font.withSize(14)
        
        return label
    }()
    
    let distanceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = label.font.withSize(12)
        
        return label
    }()
    
    let calorieLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = label.font.withSize(12)
        
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        addSubview(nameLabel)
        addSubview(timeLabel)
        addSubview(distanceLabel)
        
        //ios 9 constraint anchors
        //need x,y,width,height anchors
        nameLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
        nameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        nameLabel.widthAnchor.constraint(equalToConstant: 96).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 48).isActive = true
        
        timeLabel.leftAnchor.constraint(equalTo: nameLabel.rightAnchor, constant: 32).isActive = true
        timeLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        timeLabel.widthAnchor.constraint(equalToConstant: 96).isActive = true
        timeLabel.heightAnchor.constraint(equalToConstant: 48).isActive = true
        
        distanceLabel.leftAnchor.constraint(equalTo: timeLabel.rightAnchor, constant: 32).isActive = true
        distanceLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        distanceLabel.widthAnchor.constraint(equalToConstant: 96).isActive = true
        distanceLabel.heightAnchor.constraint(equalToConstant: 48).isActive = true
        
//        calorieLabel.leftAnchor.constraint(equalTo: distanceLabel.rightAnchor, constant: 0).isActive = true
//        calorieLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
//        calorieLabel.widthAnchor.constraint(equalToConstant: 96).isActive = true
//        calorieLabel.heightAnchor.constraint(equalToConstant: 48).isActive = true
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
}
}

