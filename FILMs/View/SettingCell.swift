//
//  SettingCell.swift
//  FILMs
//
//  Created by Meng-Ru Lin on 2020/8/15.
//  Copyright © 2020 Meng-Ru Lin. All rights reserved.
//

import UIKit

class SettingCell: UICollectionViewCell {
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Setting"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(nameLabel)
        
        self.addConstraintsWithFormat("H:|[v0]|", views: nameLabel)
        self.addConstraintsWithFormat("V:|[v0]|", views: nameLabel)
    }
    
    required init?(coder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
}
