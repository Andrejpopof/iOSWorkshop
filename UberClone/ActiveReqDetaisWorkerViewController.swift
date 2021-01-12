//
//  ActiveReqDetaisWorkerViewController.swift
//  UberClone
//
//  Created by Andrej  on 1/12/21.
//  Copyright © 2021 AMU. All rights reserved.
//

import UIKit
import MapKit
import FirebaseDatabase
import FirebaseAuth

class ActiveReqDetaisWorkerViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var nameUserLabel: UILabel!
    @IBOutlet weak var emailUserLabel: UILabel!
    @IBOutlet weak var telephoneNumberUserLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var priceOffer: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var longitude = Double()
    var latitude = Double()
    var problemDate = String()
    var nameUser = String()
    var emailUser = String()
    var telephoneUser = String()
    var desc = String()
    var statusProblem = String()
    var priceOffered = String()
    var Key = String()
    let db = Database.database().reference()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dateLabel.text = problemDate
        nameUserLabel.text = nameUser
        emailUserLabel.text = emailUser
        telephoneNumberUserLabel.text = telephoneUser
        descriptionLabel.text = desc
        statusLabel.text = statusProblem
        
        let span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        self.map.setRegion(region, animated: true)
        let ann = MKPointAnnotation()
        ann.coordinate = coordinate
        ann.title = "Problem Location"
        map.addAnnotation(ann)
        
        
        
        
    }
    func displayAlert(title:String, message:String)
    {
        let displayAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        displayAlertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(displayAlertController, animated: true, completion: nil)
    }
    
    @IBAction func sendOfferClicked(_ sender: Any) {
        
        datePicker.datePickerMode = UIDatePicker.Mode.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat  = "dd MMMM yyyy"
        let selectedDate = dateFormatter.string(from: datePicker.date)
        if priceOffer.text == ""{
            displayAlert(title: "Error", message: "Please fill the information about the offer")
        }else{
                priceOffered = priceOffer.text!
                print(selectedDate)
                print(priceOffered)
        }
        
        Database.database().reference().child("Requests").queryOrdered(byChild: "description").queryEqual(toValue: desc).observe(.value,with: { (snapshot) in
            if let snap = snapshot.value as? [String:Any]{
                for key in snap.keys{
                    self.Key = key
                }
            }
        })
        let childUpdates = ["/Requests/\(Key)/status":"dobienaPonuda"]
//        let childUpdates1 = ["/Requests/\(Key)/cenaPonuda":priceOffered]
//        let childUpdates2 = ["/Requests/\(Key)/datumPonuden":selectedDate]
        db.updateChildValues(["/Requests/\(Key)/status":"dobienaPonuda","/Requests/\(Key)/cenaPonuda":priceOffered,"/Requests/\(Key)/datumPonuden":selectedDate])
        
        
        
        
        
        
        
    }
    @IBAction func declineRequestClicked(_ sender: Any) {
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
