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
        billField.text = "0.00"
        tipField.text = "15"
        totalLabel.text = "0.00"
        peopleField.text = "1"
        perTotalLabel.text = "0.00"
        
        setDefaultTip()
        
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        // Load default tip value
        setDefaultTip()
    }
    
    func setDefaultTip(){
        // Load default tip value
        let defaults = NSUserDefaults.standardUserDefaults()
        if (defaults.objectForKey("defaultTip") != nil){
            let currentDefaultTip = defaults.objectForKey("defaultTip") as! String
            tipField.text = "\(currentDefaultTip)"
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
        billField.text = "0.00"
        tipField.text = "15"
        totalLabel.text = "0.00"
        peopleField.text = "1"
        perTotalLabel.text = "0.00"
        setDefaultTip()
    }
    
    func changeFields() {
        let billAmount = NSString(string: billField.text!).doubleValue
        let tipPercentage = NSString(string: tipField.text!).doubleValue
        let numPeople = NSString(string: peopleField.text!).doubleValue
        let tip = billAmount * tipPercentage / 100
        let total = billAmount + tip
        let totalString = roundDollar(total)
        let perTotal = total/numPeople
        let perTotalString = roundDollar(perTotal)
        totalLabel.text = totalString
        perTotalLabel.text = perTotalString
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

