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
    
   
    
    let billDefaults = UserDefaults.standard // holds the percentage default
    
   
    
       var splitNumPeople = 1
       var total=0.00
       var tipPercentages = [0.15, 0.18, 0.2]
       

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
      //Remembering the bill amount across app restarts (if <10mins)
      let previousTime = billDefaults.object(forKey: "billTime") as! NSDate
      
      if( billDefaults.object(forKey: "value") != nil)
      {
        if NSDate().timeIntervalSinceReferenceDate - previousTime.timeIntervalSinceReferenceDate < 10*60
            {
                billField.text = billDefaults.object(forKey: "value") as? String
             
            }
        }
        
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
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //Get the bill amount
        
        billDefaults.set(billField.text, forKey: "value")
        billDefaults.set(NSDate(), forKey: "billTime")
        
        billDefaults.synchronize()
        
    }
    
    
   
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
        
       
        
        //Update the tip and total labels using local currency
        tipLabel.text = convertDoubleToCurrency(amount: tip)
        totalLabel.text = convertDoubleToCurrency(amount: total)
        let totalSplit = total / Double(splitNumPeople)
        totalPerPerson.text = convertDoubleToCurrency(amount: totalSplit)
        
    }
    
    
    //This method will get the local currency
    func convertDoubleToCurrency(amount: Double) -> String{
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = Locale.current
        return numberFormatter.string(from: NSNumber(value: amount))!
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

