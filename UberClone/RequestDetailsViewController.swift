//
//  RequestDetailsViewController.swift
//  UberClone
//
//  Created by Andrej  on 1/11/21.
//  Copyright © 2021 AMU. All rights reserved.
//

import UIKit
import FirebaseAuth
import  FirebaseDatabase

class RequestDetailsViewController: UIViewController {
    @IBOutlet weak var dateRequestLabel: UILabel!
    @IBOutlet weak var typeCraftsmanLabel: UILabel!
    @IBOutlet weak var nameCraftsmanLabel: UILabel!
    @IBOutlet weak var emailCraftsman: UILabel!
    @IBOutlet weak var craftsmanTelephone: UILabel!
    @IBOutlet weak var statusuLabel: UILabel!
    @IBOutlet weak var cancelReqBtn: CustomButton!
    @IBOutlet weak var craftsmansOfferLabel: UILabel!
    @IBOutlet weak var priceOfferLabel: UILabel!
    @IBOutlet weak var cenaOfferLabel: UILabel!
    @IBOutlet weak var dateOfferLabel: UILabel!
    @IBOutlet weak var datumOfferLabel: UILabel!
    @IBOutlet weak var acceptBtn: UIButton!
    @IBOutlet weak var declineBtn: UIButton!
    @IBOutlet weak var dateForJobLabel: UILabel!
    @IBOutlet weak var datumZakazanaRabota: UILabel!
    @IBOutlet weak var finishedJobLabel: UILabel!
    @IBOutlet weak var slikaZavrsenaRabota: UIImageView!
    @IBOutlet weak var dataZavrsenaRabotaLabel: UILabel!
    @IBOutlet weak var dataZavrsenaRabota: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    var dateRequest = String()
    var typeCraftsman = String()
    var emaillCraftsman = String()
    var nameCraftsman = String()
    var telephoneCraftsman = String()
    var statusReq = String()
    var opis = String()
    var ponudenaCena = String()
    var ponudenaData = String()
    var rabotaZavrsenaData = String()
    var slika = String()
    var Key = String()
    let db = Database.database().reference()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dateRequestLabel.text = dateRequest
        typeCraftsmanLabel.text = typeCraftsman
        nameCraftsmanLabel.text = nameCraftsman
        emailCraftsman.text = emaillCraftsman
        descriptionLabel.text = opis
        craftsmanTelephone.text = telephoneCraftsman
        if statusReq == "active"{
            statusuLabel.text = "active"
        }else if statusReq == "zakazano"{
            statusuLabel.text = "Reserved"
        }else if statusReq == "zavrsenaRabota"{
            statusuLabel.text = "Finished Job"
        }else if statusReq == "dobienaPonuda"{
            statusuLabel.text = "Received Offer"
        }
        
        if statusReq == "active"{
            craftsmansOfferLabel.isHidden = true
            priceOfferLabel.isHidden = true
            cenaOfferLabel.isHidden = true
            dateOfferLabel.isHidden = true
            datumOfferLabel.isHidden = true
            acceptBtn.isEnabled = false
            acceptBtn.isHidden = true
            declineBtn.isEnabled = false
            declineBtn.isHidden = true
            dateForJobLabel.isHidden = true
            datumZakazanaRabota.isHidden = true
            finishedJobLabel.isHidden  = true
            slikaZavrsenaRabota.isHidden = true
            dataZavrsenaRabotaLabel.isHidden = true
            dataZavrsenaRabota.isHidden = true
        }else if statusReq == "zavrsenaRabota"{
            craftsmansOfferLabel.isHidden = true
            priceOfferLabel.isHidden = true
            cenaOfferLabel.isHidden = true
            dateOfferLabel.isHidden = true
            datumOfferLabel.isHidden = true
            acceptBtn.isEnabled = false
            acceptBtn.isHidden = true
            declineBtn.isEnabled = false
            declineBtn.isHidden = true
            dateForJobLabel.isHidden = true
            datumZakazanaRabota.isHidden = true
            cancelReqBtn.isEnabled = false
            cancelReqBtn.isHidden = true
            
        }else if statusReq == "dobienaPonuda"{
            dateForJobLabel.isHidden = true
            datumZakazanaRabota.isHidden = true
            cancelReqBtn.isEnabled = false
            cancelReqBtn.isHidden = true
            finishedJobLabel.isHidden  = true
            slikaZavrsenaRabota.isHidden = true
            dataZavrsenaRabotaLabel.isHidden = true
            dataZavrsenaRabota.isHidden = true
            
        }else if statusReq == "zakazano"{
            cancelReqBtn.isEnabled = false
            cancelReqBtn.isHidden = true
            craftsmansOfferLabel.isHidden = true
            priceOfferLabel.isHidden = true
            cenaOfferLabel.isHidden = true
            dateOfferLabel.isHidden = true
            datumOfferLabel.isHidden = true
            acceptBtn.isEnabled = false
            acceptBtn.isHidden = true
            declineBtn.isEnabled = false
            declineBtn.isHidden = true
            finishedJobLabel.isHidden  = true
            slikaZavrsenaRabota.isHidden = true
            dataZavrsenaRabotaLabel.isHidden = true
            dataZavrsenaRabota.isHidden = true
            
        }
        
    }
    
    func displayAlert(title:String, message:String)
    {
        let displayAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        displayAlertController.addAction(UIAlertAction(title: "OK", style: .default, handler:{
            action in
            self.performSegue(withIdentifier: "backToUser", sender: nil)
        }))
        self.present(displayAlertController, animated: true, completion: nil)
    }
    

   

    @IBAction func cancelReqClicked(_ sender: Any) {
        Database.database().reference().child("Requests").queryOrdered(byChild: "description").queryEqual(toValue: opis).observe(.childAdded,with: { (snapshot) in
            snapshot.ref.removeValue()
            Database.database().reference().child("Requests").removeAllObservers()
        })
        
        displayAlert(title: "You Just deleted the Request", message: "Please feel free to request another one at any time")
        
       
        
    }
    @IBAction func acceptClicked(_ sender: Any) {
        cenaOfferLabel.text = ponudenaCena
        datumOfferLabel.text = ponudenaData
        
        let ref  = Database.database().reference().child("Requests").queryOrdered(byChild: "description").queryEqual(toValue: opis).observe(.value,with: { (snapshot) in
            if let snap = snapshot.value as? [String:Any]{
                for key in snap.keys{
                    self.Key = key
                }
            }
        })
        let childUpdates = ["/Requests/\(Key)/status":"zakazano"]
        db.updateChildValues(childUpdates)
        
        
        
        
    }
    @IBAction func declineClicked(_ sender: Any) {
        Database.database().reference().child("Requests").queryOrdered(byChild: "description").queryEqual(toValue: opis).observe(.childAdded,with: { (snapshot) in
            snapshot.ref.removeValue()
            Database.database().reference().child("Requests").removeAllObservers()
        })
        
        displayAlert(title: "You Just declined the Request", message: "Please feel free to request another one at any time")
    }
}
