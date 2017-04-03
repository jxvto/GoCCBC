//
//  ViewController.swift
//  GoCCBC
//
//  Created by Ernest Essuah Mensah on 3/30/17.
//  Copyright © 2017 Ernest Essuah Mensah. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var homeController: HomeScreenController?

    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var textFieldBG: UITextView!
    @IBOutlet weak var headerImage: UIImageView!
    @IBOutlet weak var loginRegisterSegmentedControl: UISegmentedControl!
    @IBOutlet weak var nameTextfield: UITextField!
    @IBOutlet weak var genderTextfield: UITextField!
    @IBOutlet weak var majorTextfield: UITextField!
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var hiddenButton: UIButton!
    
    @IBOutlet weak var nameLabel: UILabel!
    var userName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupInputs()
        
    }
    
    //This function is necessary so I can refer to the user's name in the following screens.
    @IBAction func handleRegister(_ sender: Any) {
        
        guard let email = emailTextfield.text, let password = passwordTextfield.text, let name = nameTextfield.text, let gender = genderTextfield.text, let major = majorTextfield.text
            else
        { print("Form is not valid")
            return
        }
        
        
        
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: {(user: FIRUser?, error) in
            
            if error != nil {
                print(error!)
                let alertController = UIAlertController(title: "Email in use.", message: "The email you entered is already in use by another account." , preferredStyle: UIAlertControllerStyle.alert)
                let defaultAction = UIAlertAction(title: "Try again", style: UIAlertActionStyle.default, handler: nil)
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
                return
            }
            else
            {
                self.performSegue(withIdentifier: "toWelcomeScreen", sender: nil)
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
            
            self.performSegue(withIdentifier: "toWelcomeScreen", sender: nil)
        })
        
        
        nameLabel.isHidden = true
        nameLabel.text = nameTextfield.text
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
        
        
        dismiss(animated: true, completion: nil)
    }
    
    
    
    // Dismisses the picker controller view
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
    func setupInputs() {
        
        registerButton.layer.cornerRadius = 5
        
        profileImageView.layer.cornerRadius = self.profileImageView.frame.width / 2
        profileImageView.clipsToBounds = true
        profileImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleChangeProfileImage)))
    }
    
    
    func setupTextFields(textField: UITextField...) {
        
        for(_, textField) in textField.enumerated()
        {
            textField.layer.borderColor = UIColor.lightGray.cgColor
            textField.layer.cornerRadius = 0
            textField.layer.borderWidth = 0.2
        }
        
    }
    
    
    @IBAction func hideKeyboard(_ sender: Any)
    {
        
        resignResonders(textfield: nameTextfield, genderTextfield, majorTextfield, emailTextfield, passwordTextfield)
        
    }
    
    
    func resignResonders(textfield: UITextField...)
    {
        for (_, textfield) in textfield.enumerated()
        {
            textfield.resignFirstResponder()
        }
    }

    


}

