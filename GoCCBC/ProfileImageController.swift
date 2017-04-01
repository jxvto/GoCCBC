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

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var doneButton: UIButton!
    
    
    // Connects the user to the online firebase database after retrieving information
    
    @IBAction func handleRegister(_ sender: Any)
    {
        
        guard let name = (presentingViewController as! ViewController).nameTextfield.text, let gender = (presentingViewController as! ViewController).genderTextfield.text, let major = (presentingViewController as! ViewController).majorTextfield.text, let email = (presentingViewController as! ViewController).emailTextfield.text, let password = (presentingViewController as! ViewController).passwordTextfield.text
            else
        {
            print("Form is not valid")
            return
        }
        
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: {(user: FIRUser?, error) in
            
            if error != nil {
                print(error!)
                return
            }
            
            guard let uid = user?.uid else
            {
                return
            }
            
            //Successfully authenticated user
            let imgName = NSUUID().uuidString
            
            
            // Handles custom photo uploading by the user.
            // Converts the image to a .jpeg for faster loading in the app
            
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
                        
                        let values = ["name": name, "email": email, "profileImageUrl": profileImageUrl, "gender": gender, "major": major]
                        self.registerUserIntoDb(uid: uid, values: values)
                    }
                    
                })
            }
        })
        
        
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
            
            if error != nil {
                print(error!)
                return
            }
            
            //self.dismiss(animated: true, completion: nil)
        })
    }
    
   
    
    // Adds the newly authenticated user to the database of users
    private func registerUserIntoDb(uid: String, values: [String: Any]) {
        
        let ref = FIRDatabase.database().reference(fromURL: "https://goccbc.firebaseio.com/")
        let usersReference = ref.child("users").child(uid)
        
        usersReference.updateChildValues(values, withCompletionBlock: { (err, ref) in
            
            if err != nil{
                print(err!)
                return
            }
            
        })
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
        
        doneButton.setTitle("Continue", for: .normal)
        
        dismiss(animated: true, completion: nil)
    }
    
    
    
    // Dismisses the picker controller view
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImageView.layer.cornerRadius = self.profileImageView.frame.width / 2
        profileImageView.clipsToBounds = true
        doneButton.layer.cornerRadius = 5
        profileImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleChangeProfileImage)))

       
    }
    
    // To display the user's name on the welcome screen
    override func viewWillAppear(_ animated: Bool) {
        nameLabel.text = (presentingViewController as! ViewController).nameLabel.text
        nameLabel.isHidden = true
    }
    


    
}
