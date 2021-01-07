//
//  SignUpViewController.swift
//  
//
//  Created by Andrej  on 12/29/20.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase



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
    
    
    let names : [String] = ["Gligor Ivanov" , "Petar Dautovski" , "Dragan Naumov", "Vanja Atanasoski" , "Sara Popovska", "Ana Dojcinovska"]
    
    
    
    
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
        if sender.isOn{
            print("mechanic switch turned ON")
            electricianSwitch.setOn(false, animated: true)
            itWorkerSwitch.setOn(false, animated: true)
            
        }else{
            print("mechanic switch turned off")
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
    
    
    
    func displayAlert(title:String, message:String)
    {
        let displayAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        displayAlertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(displayAlertController, animated: true, completion: nil)
    }
    @IBAction func signUpClicked(_ sender: Any) {
        print("Sign Up clicked")
        
        if email.text == "" || password.text == "" || telephoneNo.text == ""
        {
            displayAlert(title: "Information missing", message: "Please enter all information to sing up")
            
        }else{
            
            if let email = email.text{
                if let password = password.text{
                    if let telephone = telephoneNo.text{
                        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
                            
                            if error != nil{
                                self.displayAlert(title: "Error", message: error!.localizedDescription)
                            }else{
                                print("Sign Up successful")
                                let number = Int.random(in: 0..<5)
                                let name = self.names[number]
                                if self.mainSwitch.isOn{
                                    let req = Auth.auth().currentUser?.createProfileChangeRequest()
                                    req?.displayName = "User"
                                    req?.commitChanges(completion: nil)

                                    let database = Database.database().reference()
                                    
                                    let user1 : [String : Any] = ["name": name as NSObject, "type":"user", "email": email, "password":password, "telephone":telephone,"typeWorker":""]
                                    database.child("Users").childByAutoId().setValue(user1)
                                    print("commited change")
                                    self.performSegue(withIdentifier: "signUpToSignIn", sender: nil)
                                }else{
                                    var typeCraftsman : String
                                    let req = Auth.auth().currentUser?.createProfileChangeRequest()
                                    req?.displayName = "Worker"
                                    req?.commitChanges(completion: nil)
                                    if self.mechanicSwitch.isOn{
                                        typeCraftsman = "mechanic"
                                    }else if self.electricianSwitch.isOn{
                                        typeCraftsman = "electrician"
                                    }else
                                    {
                                        typeCraftsman = "itWorker"
                                    }
                                    print(typeCraftsman)
                                    let database = Database.database().reference()
                                    let user2 : [String : Any] = ["name": name as NSObject, "type":"worker", "email": email, "password":password, "telephone":telephone, "typeWorker": typeCraftsman]
                                    database.child("Users").childByAutoId().setValue(user2)
                                    self.performSegue(withIdentifier: "signUpToSignIn", sender: nil)
                                    
                                }
                            }
                            
                        }
                        
                    }
                }
            }
            
            
            
            
        }
        
        
        
    }
}
