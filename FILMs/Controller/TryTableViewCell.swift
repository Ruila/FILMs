//
//  TryTableViewCell.swift
//  FILMs
//
//  Created by Meng-Ru Lin on 2020/8/12.
//  Copyright © 2020 Meng-Ru Lin. All rights reserved.
//

import UIKit

class TryTableViewCell: UITableViewCell {

    @IBOutlet weak var tryTableCell: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
