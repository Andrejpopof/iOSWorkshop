//
//  SignInViewController.swift
//  UberClone
//
//  Created by Andrej  on 12/29/20.
//  Copyright © 2020 AMU. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignInViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var SignInBtn: CustomButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func signInClicked(_ sender: Any) {
        if let email = email.text{
            if let password = password.text{
                Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
                    if error != nil
                    {
                        //self.displayAlert(title: "Error", message: error!.localizedDescription)
                        print("greska")
                    }else{
                        print("Log In successful")
                        if user?.user.displayName == "User"{
                            self.performSegue(withIdentifier: "toUser", sender: nil)
                        }else{
                            self.performSegue(withIdentifier: "toWorker", sender: nil)
                            
                        }
                    }
                })
            }
        }
        
    }
}
