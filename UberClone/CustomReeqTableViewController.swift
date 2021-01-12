//
//  CustomReeqTableViewController.swift
//  UberClone
//
//  Created by Andrej  on 1/9/21.
//  Copyright © 2021 AMU. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class CustomReeqTableViewController: UITableViewController {
    
    
    var name = String()
    var email = String()
    var telephone = String()
    var longitude = Double()
    var latitude = Double()
    var typeWorker = String()
    var sliki = [String: String]()
    var sliki1 = [String]()
    var descriptions = [String:String]()
    var descriptions1 = [String]()
    var commentForProblem = String()
    var statusRequest = String()
    var nameUser = String()
    var telephoneUser = String()
    var emailUser = String()
    var keyForUpdate = String()
    var problemLatitude = Double()
    var problemLongitude = Double()
    
    @IBOutlet weak var sendButton: UIBarButtonItem!
    
    

   
    override func viewDidLoad() {
        super.viewDidLoad()
        print(name)
        print(email)
        print(telephone)
        print(longitude)
        print(latitude)
        print(typeWorker)
        print(sliki)
        print(commentForProblem)
        sliki.keys.forEach{
            value in
            sliki1.append(value)
            
        }
        sliki.values.forEach{
            value in
            descriptions1.append(value)
        }
        print(sliki1)
        
        if let emailUser = Auth.auth().currentUser?.email{
            let ref = Database.database().reference().child("Users").queryOrdered(byChild: "email").queryEqual(toValue: email).observe(.childAdded, with:  { (snapshot) in
                if let dict = snapshot.value as? [String:AnyObject]{
                    if let userName = dict["name"] as? String{
                        if let userTelephone = dict["telephone"] as? String{
                            self.nameUser = userName
                            self.telephoneUser = userTelephone
                            self.emailUser = emailUser
                            
                        }
                    }
                }
            })
            
        }
        if let emailUser = Auth.auth().currentUser?.email{
            let ref = Database.database().reference().child("Requests").queryOrdered(byChild: "emailUser").queryEqual(toValue: emailUser).observe(.childAdded, with:  { (snapshot) in
                if let dict = snapshot.value as? [String:AnyObject]{
                    if dict["emailWorker"] as? String == self.email{
                        self.sendButton.isEnabled = false
                        self.displayAlert(title: "Wait", message: "Plese wait for your request to be delivered")
                    }
                }
            })
            
        }
        
        
        
        
        
        
       
        
       

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return sliki1.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row > sliki1.count-1{
            return UITableViewCell()
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! CustomCellReqTableViewCell
            print(sliki1[indexPath.row])
            cell.slikaView.image = UIImage(named: sliki1[indexPath.row])
            cell.opisView.text = descriptions1[indexPath.row]
            
            return cell
            
        }
    
       
    }
    
    
  
    
    func displayAlert(title:String, message:String)
    {
        let displayAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        displayAlertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(displayAlertController, animated: true, completion: nil)
    }
 
    @IBAction func sendClicked(_ sender: Any) {
         print(emailUser)
        print(nameUser)
        print(telephoneUser)
        let currentDateTime = Date()
        let formatter = DateFormatter()
        formatter.timeStyle = .none
        formatter.dateStyle = .long
        
        let dateTimeString = formatter.string(from: currentDateTime)
        
        
        
        let requestDictionary : [String:Any] = ["date" : dateTimeString , "nameWorker": self.name, "typeWorker": self.typeWorker, "emailWorker": self.email , "telephoneWorker": self.telephone , "nameUser": self.nameUser , "emailUser": self.emailUser, "telephoneUser": self.telephoneUser , "description": self.commentForProblem, "longitude": self.longitude, "latitude": self.latitude, "status": "active","cenaPonuda":"","datumPonuden":"","slikaPonudena":"","dateFinish":"","problemLatitude":problemLatitude,"problemLongitude":problemLongitude]
        Database.database().reference().child("Requests").childByAutoId().setValue(requestDictionary)
        
//        Database.database().reference().child("Users").queryOrdered(byChild: "email").queryEqual(toValue: self.emailUser).observe(.value, with: { (snapshot) in
//            if let snap = snapshot.value as? [String:AnyObject]{
//                for key in snap.keys{
//                    self.keyForUpdate = key
//                    print(self.keyForUpdate)
//                }
//            }
//        })
        
        
        
        
        self.displayAlert(title: "You are all done", message: "Thank you for making a request")
        
        
       
        
       
        
        
        
        
       
       

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



