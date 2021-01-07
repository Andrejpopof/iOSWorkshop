//
//  UserViewController.swift
//  UberClone
//
//  Created by Andrej  on 12/30/20.
//  Copyright © 2020 AMU. All rights reserved.
//

import UIKit
import FirebaseAuth
import MapKit
import FirebaseDatabase

class UserViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var commentField: UITextField!
    @IBOutlet weak var mechanicSwitch: UISwitch!
    @IBOutlet weak var electricianSwitch: UISwitch!
    @IBOutlet weak var itWorkerSwitch: UISwitch!
    var locationManager = CLLocationManager()
    var userLocation = CLLocationCoordinate2D()
    var workerLocation = CLLocationCoordinate2D()
    var workerCalled = false
    var workerOnTheWay = false
    var typeWorkerNeeded : String = ""
    var problemComment : String = ""
    var problemLongit : Double?
    var problemLatit : Double?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let longPressGR = UILongPressGestureRecognizer(target: self, action: #selector(UserViewController.longPress(gestureRecognizer:)))
        longPressGR.minimumPressDuration = 1
        map.addGestureRecognizer(longPressGR)
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        var user = Auth.auth().currentUser
        
        
        
        if let email = Auth.auth().currentUser?.email{
            //ako ima viknato
        }
        
        
        
    }
    
    
    
    
    
    @objc func longPress(gestureRecognizer: UILongPressGestureRecognizer){
        if gestureRecognizer.state == UILongPressGestureRecognizer.State.began{
            print("long press")
            let touchPoint = gestureRecognizer.location(in: self.map)
            let newCoordinate = self.map.convert(touchPoint, toCoordinateFrom: self.map)
            let newLocation = CLLocation(latitude: newCoordinate.latitude, longitude: newCoordinate.longitude)
            print(newLocation)
            problemLatit = newCoordinate.latitude
            problemLongit = newCoordinate.longitude
            let annotation = MKPointAnnotation()
            annotation.coordinate = newCoordinate
            var title = ""
            CLGeocoder().reverseGeocodeLocation(newLocation, completionHandler: { (placemarks, error) in
                if error  != nil{
                    print(error!)
                }else{
                    if let placemark = placemarks?[0]{
                        if placemark.subThoroughfare !=  nil{
                            title += placemark.subThoroughfare! + " "
                        }
                        if placemark.thoroughfare != nil{
                            title += placemark.thoroughfare! + " "
                        }
                    }
                    if title == ""{
                        title = "Added location on \(NSDate())"
                        }
                    
                    let ann = MKPointAnnotation()
                    ann.coordinate = newCoordinate
                    ann.title = title
                    self.map.addAnnotation(ann)
                }
            })
            
        }
    }
    
   
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let coord = manager.location?.coordinate{
            let center = CLLocationCoordinate2D(latitude: coord.latitude, longitude: coord.longitude)
            userLocation = center
            
            if workerOnTheWay{
                
            }else{
                let region = MKCoordinateRegion(center: center, latitudinalMeters: 0.01, longitudinalMeters: 0.01)
                map.setRegion(region, animated: true)
                map.removeAnnotations(map.annotations)
                let annotation = MKPointAnnotation()
                annotation.title = "Your location"
                annotation.coordinate = userLocation
                map.addAnnotation(annotation)
                
            }
        }
    }
    
    @IBAction func mechanicSwitchChanged(_ sender: UISwitch) {
        if sender.isOn{
            electricianSwitch.setOn(false, animated: true)
            itWorkerSwitch.setOn(false, animated: true)
        }else{
            print("Mechanich switch turned off")
        }
    }
    @IBAction func electricianSwitchChanged(_ sender: UISwitch) {
        if sender.isOn{
            mechanicSwitch.setOn(false, animated: true)
            itWorkerSwitch.setOn(false, animated: true)
        }else{
            print("Electrician switch turned off")
        }
    }
    @IBAction func itWorkerSwitchChanged(_ sender: UISwitch) {
        if sender.isOn{
            electricianSwitch.setOn(false, animated: true)
            mechanicSwitch.setOn(false, animated: true)
        }else{
            print("Mechanich switch turned off")
        }
    }
    
    @IBAction func logOutClicked(_ sender: Any) {
        try? Auth.auth().signOut()
        navigationController?.dismiss(animated: true, completion: nil)
        
    }
    func displayAlert(title:String, message:String)
    {
        let displayAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        displayAlertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(displayAlertController, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toWorkers"{
            let destinationController = segue.destination as! WorkersListTableViewController
            if mechanicSwitch.isOn{
                destinationController.selectedTypeWorker = "mechanic"
                
            }else if electricianSwitch.isOn{
                destinationController.selectedTypeWorker = "electrician"
            }else if itWorkerSwitch.isOn{
                destinationController.selectedTypeWorker = "itWorker"
            }
            if let comment = commentField?.text{
                destinationController.commentForProblem = comment
            }
            destinationController.problemLat = problemLatit
            destinationController.problemLon = problemLongit
            
            
            
            
        }
    }
    

    


    
   

}
