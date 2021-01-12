//
//  ForWorkerTableViewCell.swift
//  UberClone
//
//  Created by Andrej  on 1/12/21.
//  Copyright © 2021 AMU. All rights reserved.
//

import UIKit

class ForWorkerTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var imeLabel: UILabel!
    @IBOutlet weak var datumLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
