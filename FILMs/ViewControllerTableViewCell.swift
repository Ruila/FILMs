//
//  ViewControllerTableViewCell.swift
//  FILMs
//
//  Created by Meng-Ru Lin on 2020/7/28.
//  Copyright © 2020 Meng-Ru Lin. All rights reserved.
//

import UIKit

class ViewControllerTableViewCell: UITableViewCell {

   
    @IBOutlet weak var ProfileThumbnails: UIImageView!
    @IBOutlet weak var VideoTitle: UILabel!
    @IBOutlet weak var VideoThumbnails: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
