//
//  RequestsTableViewController.swift
//  UberClone
//
//  Created by Andrej  on 1/11/21.
//  Copyright © 2021 AMU. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class RequestsTableViewController: UITableViewController {
    
    
   var requests = [DataSnapshot]()

    override func viewDidLoad() {
        super.viewDidLoad()

        
        if let email = Auth.auth().currentUser?.email{
                Database.database().reference().child("Requests").queryOrdered(byChild: "emailUser").queryEqual(toValue: email).observe(.childAdded, with: { (snapshot) in
                let dict  =  snapshot.value as? [String:Any]
                    print(dict)
                    self.requests.append(snapshot)
                    self.tableView.reloadData()
                
                
                
            
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
        performSegue(withIdentifier: "toRequestDetails", sender: snapshot)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let reqDetailVC = segue.destination as? RequestDetailsViewController{
            if let snapshot = sender as? DataSnapshot{
                if let req = snapshot.value as? [String : AnyObject]{
                   
                                if let status = req["status"] as? String{
                                    if let dateReq = req["date"] as? String{
                                        if let typeWorker = req["typeWorker"] as? String{
                                            if let nameWorker = req["nameWorker"] as? String{
                                                if let telephoneWorker = req["telephoneWorker"] as? String{
                                                    if let emailWorker = req["emailWorker"] as? String{
                                                        if let description = req["description"] as? String{
                                                                
                                                                    
                                                                    reqDetailVC.dateRequest = dateReq
                                                                    reqDetailVC.statusReq = status
                                                                    reqDetailVC.typeCraftsman = typeWorker
                                                                    reqDetailVC.nameCraftsman = nameWorker
                                                                    reqDetailVC.telephoneCraftsman = telephoneWorker
                                                                    reqDetailVC.emaillCraftsman = emailWorker
                                                                    reqDetailVC.opis = description
                                                                    
                                                                    
                                                                    
            
                                                                
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

    
    override func viewDidAppear(_ animated: Bool) {
        
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "kelijaRequest", for: indexPath) as! RequestsTableViewCell
        
        let snapshot = requests[indexPath.row]
        if let dict = snapshot.value as? [String:AnyObject]{
            if let date = dict["date"] as? String {
                if let nameWorker = dict["nameWorker"] as? String{
                    if let status  = dict["status"] as? String {
                        
                        cell.dateLabel.text = date
                        cell.nameWorkerLabel.text = nameWorker
                        if status == "active"{
                            cell.statusView.backgroundColor = UIColor.yellow
                            cell.statusLabel.text = "Active"
                            
                        }else if status == "zakazano"{
                            cell.statusView.backgroundColor = UIColor.blue
                            cell.statusLabel.text = "Reserved"
                            
                        }else if status == "dobienaPonuda"{
                            cell.statusView.backgroundColor = UIColor.red
                            cell.statusLabel.text = "Received Offer"
                        }else if status == "zavrsenaRabota"{
                            cell.statusView.backgroundColor = UIColor.green
                            cell.statusLabel.text = "Done"
                        }
                        
                    }
                }
            }
            
            
        }
     

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
