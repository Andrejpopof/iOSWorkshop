//
//  WorkerListTableViewCell.swift
//  UberClone
//
//  Created by Andrej  on 1/2/21.
//  Copyright © 2021 AMU. All rights reserved.
//

import UIKit

class WorkerListTableViewCell: UITableViewCell {
    @IBOutlet weak var craftsmanName: UILabel!
    
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var imageCheckMark: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
