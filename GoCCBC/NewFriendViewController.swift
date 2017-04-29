//
//  NewFriendViewController.swift
//  GoCCBC
//
//  Created by Ernest Essuah Mensah on 4/24/17.
//  Copyright © 2017 Ernest Essuah Mensah. All rights reserved.
//

import UIKit

class NewFriendViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var majorLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        nameLabel.text = (presentingViewController as! NewFriendsController).name
        majorLabel.text = (presentingViewController as! NewFriendsController).major
        emailLabel.text = (presentingViewController as! NewFriendsController).email
        let imageURL = (presentingViewController as! NewFriendsController).profileImageUrl
        setupUserProfileImage(imageURL: imageURL)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.layer.cornerRadius = self.imageView.frame.width / 2
        imageView.clipsToBounds = true
    }

    
    func setupUserProfileImage(imageURL: String?)
    {
        if let profileImageUrl = imageURL {
            imageView.loadImageUsingCacheWithUrlString(profileImageUrl)
        }
    }
    

}
