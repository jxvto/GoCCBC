//
//  MapViewController.swift
//  GoCCBC
//
//  Created by Ernest Essuah Mensah on 4/24/17.
//  Copyright © 2017 Ernest Essuah Mensah. All rights reserved.
//

import UIKit

class MapViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var mapPicker: UIPickerView!
    @IBOutlet weak var mapLabel: UILabel!
    @IBOutlet weak var selectedMap: UILabel!
    
    var randomNum: Int = 0
    
    var pickerData=["","Collegiate Drive","Ivy League Drive","Foxhall Drive","Vineyard Hill Rd","Stone Spring Ct","McCurley Ave"
        ,"Old Granny Ct","Campus Drive","Pepperdine Cir"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapPicker.delegate = self
        self.mapPicker.dataSource = self
        selectedMap.isHidden = true
        imageView.isHidden = false
        mapLabel.isHidden = false

    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if(row==0)
        {
            self.imageView.image=UIImage(named: "")
            //trying to bound the image to the constrint I put on the imageview.
            self.imageView.layer.masksToBounds=true
            self.mapLabel.text = "Selected map: None Chosen"
            
        }
        if(row==1)
        {
            self.imageView.image=UIImage(named: "Colleglate.png")
            //trying to bound the image to the constrint I put on the imageview.
            self.imageView.layer.masksToBounds=true
            self.mapLabel.text = "Selected map: " + pickerData[row]
            self.selectedMap.text = pickerData[row]
            
        }
        else if(row==2)
        {
            self.imageView.image=UIImage(named: "Ivy League.png")
            self.imageView.layer.masksToBounds=true
            self.mapLabel.text = "Selected map: " + pickerData[row]
            self.selectedMap.text = pickerData[row]
            
        }
        else if(row==3)
        {
            self.imageView.image=UIImage(named: "Foxhall.png")
            self.imageView.layer.masksToBounds=true
            self.mapLabel.text = "Selected map: " + pickerData[row]
            self.selectedMap.text = pickerData[row]
            
        }
        else if(row==4)
        {
            self.imageView.image=UIImage(named: "Vineyard Hill Rd.png")
            self.imageView.layer.masksToBounds=true
            self.mapLabel.text = "Selected map: " + pickerData[row]
            self.selectedMap.text = pickerData[row]
            
        }
        else if(row==5)
        {
            self.imageView.image=UIImage(named: "StoneSpring.png")
            self.imageView.layer.masksToBounds=true
            self.mapLabel.text = "Selected map: " + pickerData[row]
            self.selectedMap.text = pickerData[row]
            
        }
        else if(row==6)
        {
            self.imageView.image=UIImage(named: "McCurley.png")
            self.imageView.layer.masksToBounds=true
            self.mapLabel.text = "Selected map: " + pickerData[row]
            self.selectedMap.text = pickerData[row]
            
        }
        else if(row==7)
        {
            self.imageView.image=UIImage(named: "Old Granny.png")
            self.imageView.layer.masksToBounds=true
            self.mapLabel.text = "Selected map: " + pickerData[row]
            self.selectedMap.text = pickerData[row]
            
        }
        else if(row==8)
        {
            self.imageView.image=UIImage(named: "Campus dr.png")
            self.imageView.layer.masksToBounds=true
            self.mapLabel.text = "Selected map: " + pickerData[row]
            self.selectedMap.text = pickerData[row]
            
        }
        else if(row==9)
        {
            self.imageView.image=UIImage(named: "Pepperdine.png")
            self.imageView.layer.masksToBounds=true
            self.mapLabel.text = "Selected map: " + pickerData[row]
            self.selectedMap.text = pickerData[row]
        }
        
    }
    
    @IBAction func randomize(_ sender: Any) {
        
        let random = arc4random_uniform(9) + 1
        randomNum = Int(random)
        self.randomMap()
        imageView.isHidden = true
        mapLabel.isHidden = true
    }
    
    
    func randomMap() {
        
        switch randomNum {
        case 1:
            self.imageView.image = UIImage(named: "Colleglate.png")
            self.mapLabel.text = "Selected map: " + pickerData[randomNum]
            self.selectedMap.text = pickerData[randomNum]
            self.imageView.layer.masksToBounds = true
            
        case 2:
            self.imageView.image=UIImage(named: "Ivy League.png")
            self.mapLabel.text = "Selected map: " + pickerData[randomNum]
            self.selectedMap.text = pickerData[randomNum]
            self.imageView.layer.masksToBounds=true
            
        case 3:
            self.imageView.image=UIImage(named: "Foxhall.png")
            self.mapLabel.text = "Selected map: " + pickerData[randomNum]
            self.selectedMap.text = pickerData[randomNum]
            self.imageView.layer.masksToBounds=true
            
        case 4:
            self.imageView.image=UIImage(named: "Vineyard Hill Rd.png")
            self.mapLabel.text = "Selected map: " + pickerData[randomNum]
            self.selectedMap.text = pickerData[randomNum]
            self.imageView.layer.masksToBounds=true
            
        case 5:
            self.imageView.image=UIImage(named: "StoneSpring.png")
            self.mapLabel.text = "Selected map: " + pickerData[randomNum]
            self.selectedMap.text = pickerData[randomNum]
            self.imageView.layer.masksToBounds=true
            
        case 6:
            self.imageView.image=UIImage(named: "McCurley.png")
            self.mapLabel.text = "Selected map: " + pickerData[randomNum]
            self.selectedMap.text = pickerData[randomNum]
            self.imageView.layer.masksToBounds=true
            
        case 7:
            self.imageView.image=UIImage(named: "Old Granny.png")
            self.mapLabel.text = "Selected map: " + pickerData[randomNum]
            self.selectedMap.text = pickerData[randomNum]
            self.imageView.layer.masksToBounds=true
            
        case 8:
            self.imageView.image=UIImage(named: "Campus dr.png")
            self.mapLabel.text = "Selected map: " + pickerData[randomNum]
            self.selectedMap.text = pickerData[randomNum]
            self.imageView.layer.masksToBounds=true
            
        case 9:
            self.imageView.image=UIImage(named: "Pepperdine.png")
            self.mapLabel.text = "Selected map: " + pickerData[randomNum]
            self.selectedMap.text = pickerData[randomNum]
            self.imageView.layer.masksToBounds=true
            
        default:
            self.imageView.image = UIImage(named: "")
            self.mapLabel.text = "Selected map: None Chosen"
            self.imageView.layer.masksToBounds=true
        }
        
    }
    
    @IBAction func beginMap(_ sender: Any) {
        
        
    }
    

    
}
