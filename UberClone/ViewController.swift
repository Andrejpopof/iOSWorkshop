//
//  ViewController.swift
//  UberClone
//
//  Created by AMU on 11/9/20.
//  Copyright © 2020 AMU. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var signUpBtn: CustomButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Loaded")
        
       // self.view.backgroundColor = UIColor.gray
        
    }

    @IBAction func signInClicked(_ sender: Any) {
        print("Sign In clicked")
    }
    
    @IBAction func signUpClicked(_ sender: Any) {
        print("Sign Up clicked")
    }
    
}

