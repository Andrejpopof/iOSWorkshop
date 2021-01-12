//
//  BioseptTableViewCell.swift
//  UberClone
//
//  Created by Andrej  on 1/12/21.
//  Copyright © 2021 AMU. All rights reserved.
//

import UIKit

class BioseptTableViewCell: UITableViewCell {
    @IBOutlet weak var DateLabel: UILabel!
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var viewStatus: UIView!
    @IBOutlet weak var statussLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
