//
//  DescTableViewCell.swift
//  Demo
//
//  Created by Ketan Saini on 08/01/18.
//  Copyright © 2018 Ketan Saini. All rights reserved.
//

import UIKit

class DescTableViewCell: UITableViewCell {
    @IBOutlet weak var lblDescription: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
