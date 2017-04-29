//
//  ViewController.swift
//  GoCCBC
//
//  Created by Ernest Essuah Mensah on 3/30/17.
//  Copyright © 2017 Ernest Essuah Mensah. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
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
    
    let genderOption = ["Male", "Female", "Unspecified"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let pickerView = UIPickerView()
        pickerView.delegate = self
        genderTextfield.inputView = pickerView
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
                
                let alertController = UIAlertController(title: "Oops, something went wrong.", message: "\(String(describing: error!.localizedDescription))" , preferredStyle: UIAlertControllerStyle.alert)
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
        let leaderBoardRef = ref.child("leaderboard").child(uid)
        let usersReference = ref.child("users").child(uid)
        
        let distanceCovered: Double = 0
        let duration: Double = 0
        let calorieCount: Double = 0
        
        usersReference.updateChildValues(values, withCompletionBlock: { (err, ref) in
            
            if err != nil{
                print(err!)
                return
            }
            
        })
        
        let value = ["name": values["name"]!, "distance": distanceCovered, "time": duration, "caloriesBurnt": calorieCount]
        
        leaderBoardRef.updateChildValues(value, withCompletionBlock: { (err, ref) in
            
            if err != nil{
                print(err!)
                return
            }
            
        })
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return genderOption.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return genderOption[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        genderTextfield.text = genderOption[row]
    }
    
    
    func donePressed() {
        genderTextfield.resignFirstResponder()
    }
    
    func setupInputs() {
        
        registerButton.layer.cornerRadius = 5
        
        // Sets up the view for the gender option picker
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: self.view.frame.size.height/6, width: self.view.frame.size.width, height: 40.0))
        toolBar.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-20.0)
        toolBar.barStyle = UIBarStyle.blackTranslucent
        toolBar.tintColor = UIColor.white
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(donePressed))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil)
        toolBar.setItems([flexSpace,doneButton], animated: true)
        genderTextfield.inputAccessoryView = toolBar

    }
    
    
    // Invokes the resign first responder methods of all the textfields.
    
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

