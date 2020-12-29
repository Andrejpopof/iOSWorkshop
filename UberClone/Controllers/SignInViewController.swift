//
//  SignInViewController.swift
//  UberClone
//
//  Created by Andrej  on 12/28/20.
//  Copyright © 2020 AMU. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {

    @IBOutlet weak var passwordTxtField: UITextField!
    @IBOutlet weak var emailTxtField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    @IBAction func signInClicked(_ sender: Any) {
        print("sign in clicked")
    }
    

}
