//
//  RequestViewController.swift
//  UberClone
//
//  Created by Andrej  on 1/8/21.
//  Copyright © 2021 AMU. All rights reserved.
//

import UIKit
import MapKit


class RequestViewController: UIViewController {
    
    let email = String()
    let locationWorker = CLLocation()
    
    @IBOutlet weak var sendButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func sendButtonClicked(_ sender: Any) {
        print("send button clicked for request")
    }

}
