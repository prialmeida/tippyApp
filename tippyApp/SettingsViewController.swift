//
//  SettingsViewController.swift
//  tippyApp
//  This class will control the setting of the app, allowing the user to change default colors and choose another default percent for tip
//  Created by Priscila Almeida on 7/8/20.
//  Copyright © 2020 Priscila Almeida. All rights reserved.
//

import UIKit

extension UIColor {

    convenience init(hex: Int) {
        let components = (
            R: CGFloat((hex >> 16) & 0xff) / 255,
            G: CGFloat((hex >> 08) & 0xff) / 255,
            B: CGFloat((hex >> 00) & 0xff) / 255
        )

        self.init(red: components.R, green: components.G, blue: components.B, alpha: 1)
    }

}


class SettingsViewController: UIViewController {

    
    //IBOutlets
    @IBOutlet weak var changeTipField: UITextField!
    
    @IBOutlet weak var firstTipLabel: UIButton!
    @IBOutlet weak var secondTipLabel: UIButton!
    @IBOutlet weak var thirdTipLabel: UIButton!

    @IBOutlet weak var purpleButton: UIButton!
    @IBOutlet weak var greenButton: UIButton!
    @IBOutlet weak var blueButton: UIButton!
    
    @IBOutlet weak var viewPercentageBox: UIView!
    
    @IBOutlet var settingsLabels: [UILabel]!
    @IBOutlet var percentageButtons: [UIButton]!
    
    
     let defaults = UserDefaults.standard // holds the percentage default
    
    let defBackground = UserDefaults.standard // holds the default color
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
        
        //Changing default percentage tip
        for i in 0...2{
            let index = String(i)
            let value = defaults.double(forKey: index)
            let newTitle = String.init(format: "%.0f", value*100)
            
            if i == 0{
                firstTipLabel.setTitle("\(newTitle)%", for: .normal)
            }
            else if i == 1{
                secondTipLabel.setTitle("\(newTitle)%", for: .normal)
            }
            else{
                thirdTipLabel.setTitle("\(newTitle)%", for: .normal)
            }
            
        }
        
        //Changing colors
       changeColors()
   
    }
    
   
    //This method will allow user to change the default tip
    @IBAction func selectedDefaultTip(_ sender: UIButton) {
        
        changeTipField.endEditing(true)
        
        
        firstTipLabel.isSelected = false
        secondTipLabel.isSelected = false
        thirdTipLabel.isSelected = false
        
        sender.isSelected = true
        
        if changeTipField.text != ""{
                
                var percentLabel = ""
           
            if changeTipField != nil
            {
                percentLabel = changeTipField.text!
                
            }
                var tipPercentage = Double(percentLabel) ?? 0
                
                tipPercentage = tipPercentage / 100
                    
            sender.setTitle("\(percentLabel)%", for: .normal)
            
            if firstTipLabel.isSelected {
                defaults.set(tipPercentage, forKey: "0")
            }
            else if secondTipLabel.isSelected {
                defaults.set(tipPercentage, forKey: "1")
            }
            else {
                defaults.set(tipPercentage, forKey: "2")
            }
            
            defaults.synchronize()
        }
        
            
        
        changeTipField.text=""
            
      
    }
    
    //This method will allow user to select the app color
    @IBAction func selectBackground(_ sender: UIButton) {
        
        
        greenButton.isSelected = false
        purpleButton.isSelected = false
        blueButton.isSelected = false
         sender.isSelected = true
        
        if greenButton.isSelected{
            defBackground.set(0xCAEFBD, forKey: "bgColor")
            defBackground.set(0x2BA15C, forKey: "labelColor")
            changeColors()
            
        }
        if purpleButton.isSelected{
             defBackground.set(0xDCD4FA, forKey: "bgColor")
             defBackground.set(0xAF52DE, forKey: "labelColor")
            changeColors()
             
        }
        if blueButton.isSelected{
            defBackground.set(0xABECED, forKey: "bgColor")
            defBackground.set(0x2153DE, forKey: "labelColor")
            changeColors()
             
        }
            
        
    }
    
    
    //This method will chnage the app color in accordance with the user's choice
    func changeColors()
    {
        
        let colorBG = defBackground.integer(forKey: "bgColor")
         let colorLabels = defBackground.integer(forKey: "labelColor")
        
        //BACKGROUNDS
        viewPercentageBox.backgroundColor = UIColor(hex:colorBG)
        
        
        //LABELS
          for labels in settingsLabels{
        labels.textColor = UIColor(hex:colorLabels)
        }
        
        //BUTTONS
        for button in percentageButtons{
            button.tintColor = UIColor(hex:colorLabels)
        }
        
    }
    
    

}
