//
//  RequestsTableViewCell.swift
//  UberClone
//
//  Created by Andrej  on 1/11/21.
//  Copyright © 2021 AMU. All rights reserved.
//

import UIKit

class RequestsTableViewCell: UITableViewCell {

    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var craftsmanLabel: UILabel!
    @IBOutlet weak var nameWorkerLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
