//
//  CustomCellReqTableViewCell.swift
//  UberClone
//
//  Created by Andrej  on 1/9/21.
//  Copyright © 2021 AMU. All rights reserved.
//

import UIKit

class CustomCellReqTableViewCell: UITableViewCell {

    @IBOutlet weak var view: UIView!
    @IBOutlet weak var slikaView: UIImageView!
    @IBOutlet weak var opisView: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
