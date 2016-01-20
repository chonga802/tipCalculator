//
//  ViewController.swift
//  tips2
//
//  Created by Christine Hong on 12/29/15.
//  Copyright © 2015 Christine Hong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipField: UITextField!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var peopleField: UITextField!
    @IBOutlet weak var perTotalLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background.jpg")!)
        billField.text = ""
        tipField.text = "15"
        totalLabel.text = "0.00"
        peopleField.text = "1"
        perTotalLabel.text = "0.00"
        
        getDefaultTip()
        
        // Set last app values if has been less than 10 minutes
        let defaults = NSUserDefaults.standardUserDefaults()
        if (defaults.objectForKey("lastDate") != nil){
            let lastDate = defaults.objectForKey("lastDate") as! NSDate
            let elapsedTime = NSDate().timeIntervalSinceDate(lastDate)
            if (elapsedTime < 600) {
                getSetValues()
            }
        }
        
        // Save current date
        let currentDate = NSDate()
        defaults.setObject(currentDate, forKey: "lastDate")
        defaults.synchronize()
        
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        billField.becomeFirstResponder()
    }
    
    func getDefaultTip(){
        // Load default tip value
        let defaults = NSUserDefaults.standardUserDefaults()
        if (defaults.objectForKey("defaultTip") != nil){
            let currentDefaultTip = defaults.objectForKey("defaultTip") as! String
            tipField.text = "\(currentDefaultTip)"
        }
    }
    
    func getSetValues(){
        // Load values set last session
        let defaults = NSUserDefaults.standardUserDefaults()
        if (defaults.objectForKey("setBillAmount") != nil){
            let setBillAmount = defaults.objectForKey("setBillAmount") as! String
            billField.text = "\(setBillAmount)"
        }
        if (defaults.objectForKey("setTipPercentage") != nil){
            let setTipPercentage = defaults.objectForKey("setTipPercentage") as! String
            tipField.text = "\(setTipPercentage)"
        }
        if (defaults.objectForKey("setTotal") != nil){
            let setTotal = defaults.objectForKey("setTotal") as! String
            totalLabel.text = "\(setTotal)"
        }
        if (defaults.objectForKey("setNumPeople") != nil){
            let setNumPeople = defaults.objectForKey("setNumPeople") as! String
            peopleField.text = "\(setNumPeople)"
        }
        if (defaults.objectForKey("setPerTotal") != nil){
            let setPerTotal = defaults.objectForKey("setPerTotal") as! String
            perTotalLabel.text = "\(setPerTotal)"
        }
    }
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func roundDollar(val:Double) ->String {
        let total = Double(round(100*val)/100)
        let dollar:Int = Int(val)
        let cents = Int(round((total - Double(dollar)) * 100))
        if cents == 0 {
            return "\(dollar).00"
        } else if cents < 0 {
            return "\(dollar).0\(cents)"
        } else {
            return "\(dollar).\(cents)"
        }
    }
    
    @IBAction func clearFields(sender: AnyObject) {
        billField.text = ""
        tipField.text = "15"
        totalLabel.text = "0.00"
        peopleField.text = "1"
        perTotalLabel.text = "0.00"
        
        getDefaultTip()
        
        // Save default
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject("", forKey: "setBillAmount")
        defaults.setObject(NSString(string: tipField.text!), forKey: "setTipPercentage" )
        defaults.setObject("0.00", forKey: "setTotal" )
        defaults.setObject("1", forKey: "setNumPeople" )
        defaults.setObject("0.00", forKey: "setPerTotal" )
        defaults.synchronize()
    }
    
    func changeFields() {
        let billAmount = NSString(string: billField.text!).doubleValue
        let tipPercentage = NSString(string: tipField.text!).intValue
        let numPeople = NSString(string: peopleField.text!).intValue
        let tip = billAmount * Double(tipPercentage) / 100
        let total = billAmount + tip
        let totalString = roundDollar(total)
        let perTotal = total/Double(numPeople)
        let perTotalString = roundDollar(perTotal)
        totalLabel.text = totalString
        perTotalLabel.text = perTotalString
        
        // Save entered values
        let defaults = NSUserDefaults.standardUserDefaults()
        if billAmount == Double(0) {
            defaults.setObject("", forKey: "setBillAmount")
        } else {
            defaults.setObject(roundDollar(billAmount), forKey: "setBillAmount")
        }
        defaults.setObject(String(tipPercentage), forKey: "setTipPercentage" )
        defaults.setObject(totalString, forKey: "setTotal" )
        defaults.setObject(String(numPeople), forKey: "setNumPeople" )
        defaults.setObject(perTotalString, forKey: "setPerTotal" )
        defaults.synchronize()
    }

    @IBAction func billChanged(sender: AnyObject) {
        changeFields()
    }

    @IBAction func tipChanged(sender: AnyObject) {
        changeFields()
    }
    
    @IBAction func peopleChanged(sender: AnyObject) {
        changeFields()
    }
    
    
    
}

