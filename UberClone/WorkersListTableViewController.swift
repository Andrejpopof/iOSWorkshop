//
//  WorkersListTableViewController.swift
//  UberClone
//
//  Created by Andrej  on 1/2/21.
//  Copyright © 2021 AMU. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import MapKit


class WorkersListTableViewController: UITableViewController {
    var selectedTypeWorker : String = ""
    var commentForProblem : String = ""
    var problemLat = Double()
    var problemLon = Double()
    var workers : [DataSnapshot] = []
    var requests : [DataSnapshot] = []
    
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        print(selectedTypeWorker)
//        print(commentForProblem)
//        print(problemLat!)
//        print(problemLon!)
        let reference = Database.database().reference().child("Users").queryOrdered(byChild: "typeWorker")
        reference.queryEqual(toValue: selectedTypeWorker).observe(.childAdded, with:{ (snapshot) in
            if let dictionary = snapshot.value as? [String : Any]{
                print(dictionary)
                self.workers.append(snapshot)
                self.tableView.reloadData()
            }
            
            
        })
       
        
        
       
    }
    
    
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return workers.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! WorkerListTableViewCell
        
        let snapshot = workers[indexPath.row]
        if let dict  = snapshot.value as? [String:AnyObject]{
            if let name = dict["name"] as? String{
                if let latWorker = dict["latitude"] as? Double{
                    if let lonWorker = dict["longitude"] as? Double{
                        if let emailUser = Auth.auth().currentUser?.email{
                            let ref = Database.database().reference().child("Requests").queryOrdered(byChild: "emailUser").queryEqual(toValue: emailUser).observe(.childAdded, with:  { (snapshot) in
                                if let dict = snapshot.value as? [String:AnyObject]{
                                    if dict["nameWorker"] as? String == name{
                                        cell.accessoryType = UITableViewCell.AccessoryType.checkmark
                                        //self.sendButton.isEnabled = false
                                        //displayAlert(title: "Wait", message: "Plese wait for your request to be delivered")
                                    }
                                }
                            })
                            
                        }
                        let problemLocation = CLLocation(latitude: self.problemLat, longitude: self.problemLon)
                        let workerLocation = CLLocation(latitude: latWorker, longitude: lonWorker)
                        let distance = workerLocation.distance(from: problemLocation) / 1000
                        let roundedDistance = round(distance*100)/100
                        cell.craftsmanName.text = name
                        cell.distance.text = String(roundedDistance) + " km away"
                        
                        
                        
                    }
                }
            }
        }
            
        

        // Configure the cell...

        return cell
    }
 
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let snapshot = workers[indexPath.row]
        performSegue(withIdentifier: "toRequest", sender: snapshot)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let acceptVC = segue.destination as? CustomReeqTableViewController{
            if let snapshot = sender as? DataSnapshot{
                if let workers = snapshot.value as? [String:AnyObject]{
                    if let name = workers["name"] as? String{
                        if let typeWorker = workers["typeWorker"] as? String{
                            if let images = workers["images"] as? [String:String]{
                                if let lat = workers["latitude"] as? Double{
                                    if let lon = workers["longitude"] as? Double{
                                        if let email = workers["email"] as? String{
                                            if let telephone = workers["telephone"] as? String{
                                                
                                                    
                                                    acceptVC.name = name
                                                    acceptVC.typeWorker = typeWorker
                                                    acceptVC.sliki = images
                                                    acceptVC.latitude = lat
                                                    acceptVC.longitude = lon
                                                    acceptVC.email = email
                                                    acceptVC.telephone = telephone
                                                    acceptVC.commentForProblem = commentForProblem
                                                    acceptVC.problemLatitude = problemLat
                                                    acceptVC.problemLongitude = problemLon
                                                
                                                
                                                
                                                
                                                
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
