//
//  SignUpViewController.swift
//  
//
//  Created by Andrej  on 12/29/20.
//

import UIKit

class SignUpViewController: UIViewController {
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var telephoneNo: UITextField!
    @IBOutlet weak var mainSwitch: UISwitch!
    @IBOutlet weak var labelStatic: UILabel!
    
    @IBOutlet weak var typeWorkerStack: UIStackView!
    @IBOutlet weak var typeWorkerSwitchesStack: UIStackView!
    var userWorking = true
    
    @IBOutlet weak var mechanicSwitch: UISwitch!
    
    @IBOutlet weak var electricianSwitch: UISwitch!
    
    @IBOutlet weak var itWorkerSwitch: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()

        labelStatic.isHidden = true
        typeWorkerStack.isHidden = true
        typeWorkerSwitchesStack.isHidden = true
    }
    
    
    @IBAction func mainSwitchChanged(_ sender: UISwitch) {
        if mainSwitch.isOn{
            
            labelStatic.isHidden = true
            typeWorkerStack.isHidden = true
            typeWorkerSwitchesStack.isHidden = true
        }
        else{
            labelStatic.isHidden = false
            typeWorkerStack.isHidden = false
            typeWorkerSwitchesStack.isHidden = false
        }
        
        
    }
    
    @IBAction func mechanicSwitchChanged(_ sender: UISwitch) {
        
        if sender.isOn == true{
            print("asd")
            electricianSwitch.setOn(false, animated: true)
            itWorkerSwitch.setOn(false, animated: true)
        }
        else{
            print("dsa")
        }
        
    }
    
    @IBAction func electricianSwitchChanged(_ sender: UISwitch) {
        if sender.isOn == true{
            print("electritian switch turned ON")
            mechanicSwitch.setOn(false, animated: true)
            itWorkerSwitch.setOn(false, animated: true)
        }
        else{
            print("electritian switch turned OFF")
        }
    }
    @IBAction func itWorkerSwitchChanged(_ sender: UISwitch) {
        if sender.isOn == true{
            print("it worker switch turned ON")
            mechanicSwitch.setOn(false, animated: true)
            electricianSwitch.setOn(false, animated: true)
        }
        else{
            print("it worker switch turned OFF")
        }
    }
}
