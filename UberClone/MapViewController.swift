//
//  MapViewController.swift
//  UberClone
//
//  Created by Andrej  on 1/13/21.
//  Copyright © 2021 AMU. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet weak var map: MKMapView!
    
    var location = CLLocationCoordinate2D()

    override func viewDidLoad() {
        super.viewDidLoad()
        let span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
        
        let region = MKCoordinateRegion(center: location, span: span)
        self.map.setRegion(region, animated: true)
        let ann = MKPointAnnotation()
        ann.coordinate = location
        ann.title = "Problem Location"
        map.addAnnotation(ann)

        
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
