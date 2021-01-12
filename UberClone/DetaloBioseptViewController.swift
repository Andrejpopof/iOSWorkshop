//
//  DetaloBioseptViewController.swift
//  UberClone
//
//  Created by Andrej  on 1/12/21.
//  Copyright © 2021 AMU. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class DetaloBioseptViewController: UIViewController {
    
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var telephoneNoLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    var longitude = Double()
    var latitude = Double()
    var dateOffered = String()
    var nameUser = String()
    var emailUser = String()
    var telephoneUser = String()
    var statusProblem = String()
    var priceOffered = String()
    var Key = String()
    let db = Database.database().reference()

    @IBOutlet weak var datePicker: UIDatePicker!
    override func viewDidLoad() {
        super.viewDidLoad()

        dateLabel.text = dateOffered
        nameLabel.text = nameUser
        emailLabel.text = emailUser
        telephoneNoLabel.text = telephoneUser
        statusLabel.text = statusProblem
    }
    
    @IBAction func navigateToMapClicked(_ sender: Any) {
    }
    
  
    @IBAction func finishJobClicked(_ sender: Any) {
    }
    
}
