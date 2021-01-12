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
import MapKit

class DetaloBioseptViewController: UIViewController,MKMapViewDelegate {
    
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var telephoneNoLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    var opis = String()
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
    var latitudeProblem = Double()
    var longitudeProblem = Double()
    var address = String()

    @IBOutlet weak var datePicker: UIDatePicker!
    override func viewDidLoad() {
        super.viewDidLoad()

        dateLabel.text = dateOffered
        nameLabel.text = nameUser
        emailLabel.text = emailUser
        telephoneNoLabel.text = telephoneUser
        statusLabel.text = statusProblem
        getAddressFromLatLon(pdblLatitude: latitudeProblem, withLongitude: longitudeProblem)
        
        
        
    }
    
    func getAddressFromLatLon(pdblLatitude: Double, withLongitude pdblLongitude: Double) {
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        let lat: Double = pdblLatitude
        //21.228124
        let lon: Double = pdblLongitude
        //72.833770
        let ceo: CLGeocoder = CLGeocoder()
        center.latitude = lat
        center.longitude = lon
        
        let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
        
        
        ceo.reverseGeocodeLocation(loc, completionHandler:
            {(placemarks, error) in
                if (error != nil)
                {
                    print("reverse geodcode fail: \(error!.localizedDescription)")
                }
                let pm = placemarks! as [CLPlacemark]
                
                if pm.count > 0 {
                    let pm = placemarks![0]
//                    print(pm.country)
//                    print(pm.locality)
//                    print(pm.subLocality)
//                    print(pm.thoroughfare)
//                    print(pm.postalCode)
//                    print(pm.subThoroughfare)
                    var addressString : String = ""
                    if pm.subLocality != nil {
                        addressString = addressString + pm.subLocality! + ", "
                    }
                    if pm.thoroughfare != nil {
                        addressString = addressString + pm.thoroughfare! + ", "
                    }
                    if pm.locality != nil {
                        addressString = addressString + pm.locality! + ""
                    }
//                    if pm.country != nil {
//                        addressString = addressString + pm.country! + ", "
//                    }
//                    if pm.postalCode != nil {
//                        addressString = addressString + pm.postalCode! + " "
//                    }
                    
                    
                    print(addressString)
                    self.addressLabel.text = addressString
                }
        })
        
    }
    
    
    
    @IBAction func navigateToMapClicked(_ sender: Any) {
        
       
    }
    
  
    @IBAction func finishJobClicked(_ sender: Any) {
        datePicker.datePickerMode = UIDatePicker.Mode.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat  = "dd MMMM yyyy"
        let selectedDate = dateFormatter.string(from: datePicker.date)
        
        Database.database().reference().child("Requests").queryOrdered(byChild: "description").queryEqual(toValue: opis).observe(.value,with: { (snapshot) in
            if let snap = snapshot.value as? [String:Any]{
                for key in snap.keys{
                    self.Key = key
                }
            }
        })
        
          db.updateChildValues(["/Requests/\(Key)/status":"zavrsenaRabota","/Requests/\(Key)/dateFinish":selectedDate])
          
        
    }
    
}
