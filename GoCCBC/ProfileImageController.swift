//
//  ProfileImageController.swift
//  GoCCBC
//
//  Created by Ernest Essuah Mensah on 3/31/17.
//  Copyright © 2017 Ernest Essuah Mensah. All rights reserved.
//

import UIKit
import Firebase

class ProfileImageController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
   
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var updateButton: UIButton!
    
    // Connects the user to the online firebase database after retrieving information
    @IBAction func updateProfileImage(_ sender: Any) {
        changeProfileImage()
        
        let alertController = UIAlertController(title: "Sucess", message: "Your profile image was updated." , preferredStyle: UIAlertControllerStyle.alert)
        let defaultAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil)
        alertController.addAction(defaultAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    // Allows the user to select a custom image using the picker controller
    func handleChangeProfileImage() {
        let picker = UIImagePickerController()
        
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    
    // Allows the user to select a custom image using the picker controller
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        
        var selectedImageFromPicker: UIImage?
        
        
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            selectedImageFromPicker = editedImage
            
        } else if let originalImage = info["UIImagePickerControllerImage"] as? UIImage {
            selectedImageFromPicker = originalImage
            
        }
        
        if let selectedImage = selectedImageFromPicker {
            profileImageView.image = selectedImage
        }
        
        updateButton.isHidden = false
        updateButton.setTitle("Update", for: .normal)
        
        dismiss(animated: true, completion: nil)
    }
    
    
    
    // Dismisses the picker controller view
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        dismiss(animated: true, completion: nil)
    }
    
    
    func setupUser() {
        guard let uid = FIRAuth.auth()?.currentUser?.uid else {
            return
        }
        
        FIRDatabase.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                
                
                let user = User()
                user.setValuesForKeys(dictionary)
                self.setupUserProfileImage(user: user)
                
            }
        }, withCancel: nil)
    }
    
    // Calls the method that uses caching to retrieve the user's profile image.
    func setupUserProfileImage(user: User)
    {
        if let profileImageUrl = user.profileImageUrl {
            profileImageView.loadImageUsingCacheWithUrlString(profileImageUrl)
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUser()
        profileImageView.layer.cornerRadius = self.profileImageView.frame.width / 2
        profileImageView.clipsToBounds = true
        updateButton.layer.cornerRadius = 5
        updateButton.isHidden = true
        profileImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleChangeProfileImage)))

       
    }
    
    
    
    func changeProfileImage()
    {
        guard let uid = FIRAuth.auth()?.currentUser?.uid else {
            return
        }
        
        //Successfully authenticated user
        let imgName = NSUUID().uuidString
        
        
        // Handles custom photo uploading by the user.
        // Converts the image to a .jpeg for faster loading in the app
        
        let ref = FIRDatabase.database().reference(fromURL: "https://goccbc.firebaseio.com/")
        let usersReference = ref.child("users").child(uid)
        
        let storageRef = FIRStorage.storage().reference().child("profile_Images").child("\(imgName).jpg")
        
        if let profileImg = self.profileImageView.image, let uploadData = UIImageJPEGRepresentation(profileImg, 0.1)
        {
            storageRef.put(uploadData, metadata: nil, completion: { (metadata, error) in
                
                if error != nil
                {
                    print(error!)
                    return
                }
                
                if let profileImageUrl = metadata?.downloadURL()?.absoluteString
                {
                    
                    let values = ["profileImageUrl": profileImageUrl]
                    usersReference.updateChildValues(values, withCompletionBlock: { (err, ref) in
                        
                        if err != nil{
                            print(err!)
                            return
                        }
                    })
                }
                })
        }
    }
}
