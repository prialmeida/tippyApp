//
//  ViewController.swift
//  tippyApp
//  This class is the main interceface for the app. It allow the user to choose the bill amount and calculate how much the bill will be with the tip. Also allow the user to calculate how much will be spliting the bill
//  Created by Priscila Almeida on 7/8/20.
//  Copyright © 2020 Priscila Almeida. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var secondView = SettingsViewController() //Creates an instace of the settings class
    
    @IBOutlet var allLabels: [UILabel]! //Array with a colection of labels
    
        
    @IBOutlet weak var billField: UITextField!
    
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var totalPerPerson: UILabel!
    @IBOutlet weak var splitPeopleTotal: UILabel!
    
    @IBOutlet weak var tipControl: UISegmentedControl!
    
 
    
    @IBOutlet weak var mainView: UIView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //Getting default tip Percentage
        for i in 0...2{
            let index = String(i)
            let value = secondView.defaults.double(forKey: index)
            tipPercentages.insert(value, at: i)
            let newTitle = String.init(format: "%.0f", value*100)
            tipControl.setTitle("\(newTitle)%", forSegmentAt: i)
            
        }
        
        //Getting default colors
        changeColors()
        
      
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
           super.viewDidAppear(animated)
        
        billField.becomeFirstResponder() //Keyboard will show as soon as the app open
           
       }

    
    var splitNumPeople = 1
    var total=0.00
    var tipPercentages = [0.15, 0.18, 0.2]
    

    //This method will allow user to choose how many people will be spliting the bill
    @IBAction func stepperButton(_ sender: UIStepper) {
        
        splitPeopleTotal.text = String.init(format: "%.0f", sender.value)
        
        splitNumPeople = Int(sender.value)
        
        let totalSplit = total / Double(splitNumPeople)
        totalPerPerson.text = String.init(format: "$%.2f", totalSplit)
        
        
    }
    
    //This method makes the keyboard go away with any tap in any place of the app
    @IBAction func onTap(_ sender: Any) {
        
        view.endEditing(true)
    }
    
    //This method calculates how much will be the tip and the total bill depending in which percentage the user chooses
    @IBAction func calculateTip(_ sender: Any) {
        
     
        //Get the bill amount
        let bill = Double(billField.text!) ?? 0
        
        //Calculate the tip and total
        
        let tip = bill * tipPercentages[tipControl.selectedSegmentIndex]
        total = bill + tip
        
    
        //Update the tip and total labels
        tipLabel.text = String.init(format: "$%.2f", tip)
        totalLabel.text = String.init(format: "$%.2f", total)
        let totalSplit = total / Double(splitNumPeople)
        totalPerPerson.text = String.init(format: "$%.2f", totalSplit)
        
    }
    
    //This method will change the colors of the app depending in what the user chooses
    func changeColors()
    {
        
        let colorBG = secondView.defBackground.integer(forKey: "bgColor")
        let colorLabels = secondView.defBackground.integer(forKey: "labelColor")
        
        //BACKGROUNDS
        mainView.backgroundColor = UIColor(hex:colorBG)
        
        
        //LABELS
        for labels in allLabels{
            labels.textColor = UIColor(hex:colorLabels)
        }
        
    }
    
    
    
    
}

