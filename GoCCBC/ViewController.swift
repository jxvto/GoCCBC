//
//  ViewController.swift
//  GoCCBC
//
//  Created by Ernest Essuah Mensah on 3/30/17.
//  Copyright © 2017 Ernest Essuah Mensah. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
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
    
    @IBAction func hideKeyboard(_ sender: Any) {
        
        resignResonders(textfield: nameTextfield, genderTextfield, majorTextfield, emailTextfield, passwordTextfield)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textFieldBG.isHidden = true
        setupInputs()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    func setupInputs() {
        textFieldBG.layer.cornerRadius = 5
        setupTextFields(textField: nameTextfield, majorTextfield, emailTextfield, passwordTextfield)
        registerButton.layer.cornerRadius = 5
    }
    
    func setupTextFields(textField: UITextField...) {
        
        for(_, textField) in textField.enumerated()
        {
            textField.layer.borderColor = UIColor.lightGray.cgColor
            textField.layer.cornerRadius = 0
            textField.layer.borderWidth = 0.2
        }
        
    }
    
    func resignResonders(textfield: UITextField...)
    {
        for (_, textfield) in textfield.enumerated()
        {
            textfield.resignFirstResponder()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

