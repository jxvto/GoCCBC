//
//  LoginController.swift
//  GoCCBC
//
//  Created by Ernest Essuah Mensah on 3/31/17.
//  Copyright © 2017 Ernest Essuah Mensah. All rights reserved.
//

import UIKit
import Firebase

class LoginController: UIViewController {

    @IBOutlet weak var textBG: UITextView!
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    @IBOutlet weak var hiddenButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    
    
    // Logs the user to the database
    @IBAction func handleLogin(_ sender: Any)
    {
        guard let email = emailTextfield.text, let password = passwordTextfield.text
            else
        { print("Form is not valid")
            return
        }
        
        
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
            
            if error != nil {
                print(error!)
                return
            }
            
            //Test for connection
            print("Success")

            self.dismiss(animated: true, completion: nil)
        })
    }
    
    
    @IBAction func hideKeyboard(_ sender: Any) {
        resignResonders(textfield: emailTextfield, passwordTextfield)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textBG.layer.cornerRadius = 5
        loginButton.layer.cornerRadius = 5

    }

    func resignResonders(textfield: UITextField...)
    {
        for (_, textfield) in textfield.enumerated()
        {
            textfield.resignFirstResponder()
        }
    }

}
