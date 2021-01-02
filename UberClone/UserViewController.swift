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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let longPressGR = UILongPressGestureRecognizer(target: self, action: #selector(UserViewController.longPress(gestureRecognizer:)))
        longPressGR.minimumPressDuration = 1
        map.addGestureRecognizer(longPressGR)
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        
        
        if let email = Auth.auth().currentUser?.email{
            //ako ima viknato
        }
        
        
        
    }
    
    @objc func longPress(gestureRecognizer: UILongPressGestureRecognizer){
        if gestureRecognizer.state == UILongPressGestureRecognizer.State.began{
            print("long press")
            let touchPoint = gestureRecognizer.location(in: self.map)
            let newCoordinate = self.map.convert(touchPoint, toCoordinateFrom: self.map)
            let newLocation = CLLocationCoordinate2D(latitude: newCoordinate.latitude, longitude: newCoordinate.longitude)
            print(newLocation)
            let ann = MKPointAnnotation()
            ann.coordinate = newCoordinate
            ann.title = "Added location on \(NSDate())"
            self.map.addAnnotation(ann)
            
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
    
    @IBAction func viewAllWorkersClicked(_ sender: Any) {
    }
    
   
}
