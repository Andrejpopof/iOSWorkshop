//
//  BioseptTableViewController.swift
//  UberClone
//
//  Created by Andrej  on 1/12/21.
//  Copyright © 2021 AMU. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class BioseptTableViewController: UITableViewController {
    
    var model = ["1","2","3"]
    var requests : [DataSnapshot] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        if let email = Auth.auth().currentUser?.email{
            let reference = Database.database().reference().child("Requests").queryOrdered(byChild: "emailWorker")
            reference.queryEqual(toValue: email).observe(.childAdded, with:{ (snapshot) in
                if let dictionary = snapshot.value as? [String : Any]{
                    print(dictionary)
                    self.requests.append(snapshot)
                    self.tableView.reloadData()
                }
                
                
            })
            
            
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return requests.count
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let snapshot = requests[indexPath.row]
        performSegue(withIdentifier: "toBiosept", sender: snapshot)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let acceptVC = segue.destination as? DetaloBioseptViewController{
            if let snapshot = sender as? DataSnapshot{
                if let workers = snapshot.value as? [String:AnyObject]{
                    if let nameUser = workers["nameUser"] as? String{
                        if let emailUser = workers["emailUser"] as? String{
                            if let date = workers["datumPonuden"] as? String{
                                if let lat = workers["latitude"] as? Double{
                                    if let lon = workers["longitude"] as? Double{
                                        if let opis = workers["description"] as? String{
                                            if let telephoneUser = workers["telephoneUser"] as? String{
                                                if let status = workers["status"] as? String {
                                                    if let priceOffered = workers["cenaPonuda"] as? String{
                                                        acceptVC.dateOffered = date
                                                        acceptVC.nameUser = nameUser
                                                        acceptVC.emailUser = emailUser
                                                        acceptVC.latitude = lat
                                                        acceptVC.longitude = lon
                                                        acceptVC.telephoneUser = telephoneUser
                                                        acceptVC.statusProblem = status
                                                        acceptVC.priceOffered = priceOffered
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
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "kelijaaa", for: indexPath) as! BioseptTableViewCell
        
//        cell.DateLabel.text = model[indexPath.row]
//        cell.userNameLabel.text = model[indexPath.row]
        let snapshot = requests[indexPath.row]
        if let dict  = snapshot.value as? [String:AnyObject]{
            if let name = dict["nameUser"] as? String{
                if let date = dict["datumPonuden"] as? String{
                    if let status = dict["status"] as? String{
                        if status == "zakazano" || status == "zavrsenaRabota"
                        {
                            print("tuka sum")
                            cell.DateLabel.text = date
                            cell.userNameLabel.text = name
                            if status == "zakazano"{
                                cell.viewStatus.backgroundColor = UIColor.red
                                cell.statussLabel.text = "Reserved"
                            }else{
                                cell.viewStatus.backgroundColor = UIColor.green
                                cell.statussLabel.text = "Job Done"
                            }
                            
                        }
                        
                    }
                    
                }
            }
        }

        // Configure the cell...

        return cell
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
