//
//  SettingsViewController.swift
//  tips2
//
//  Created by Christine Hong on 1/18/16.
//  Copyright © 2016 Christine Hong. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
 
    @IBOutlet weak var newDefault: UITextField!
    @IBOutlet weak var setDefaultButton: UIButton!
    @IBOutlet weak var currentDefault: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        currentDefault.text = "15%"
        // Load default tip value
        let defaults = NSUserDefaults.standardUserDefaults()
        if (defaults.objectForKey("defaultTip") != nil){
            let currentDefaultTip = defaults.objectForKey("defaultTip") as! String
            currentDefault.text = "\(currentDefaultTip)%"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func setDefaultTip(sender: UIButton) {
        var newDefaultTip = NSString(string: newDefault.text!).intValue
        if newDefaultTip == 0 {
            newDefaultTip = 15
        }
        // Save default tip value
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(String(newDefaultTip), forKey: "defaultTip" )
        defaults.synchronize()
        newDefault.text = ""
        currentDefault.text = "\(newDefaultTip)%"
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
