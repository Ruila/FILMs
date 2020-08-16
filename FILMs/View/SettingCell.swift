//
//  SettingCell.swift
//  FILMs
//
//  Created by Meng-Ru Lin on 2020/8/15.
//  Copyright © 2020 Meng-Ru Lin. All rights reserved.
//

import UIKit

class SettingCell: UICollectionViewCell {
    
    var setting: Setting? {
        didSet {
            nameLabel.text = setting?.name
            
            if let imageName = setting?.imageName {
                iconImageView.image = UIImage(named: imageName)
            }
        }
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Setting"
        
        return label
    }()
    
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "setting")
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(nameLabel)
        addSubview(iconImageView)
        self.addConstraintsWithFormat("H:|-8-[v0(30)]-8-[v1]|", views: iconImageView, nameLabel)
        self.addConstraintsWithFormat("V:|[v0]|", views: nameLabel)
        self.addConstraintsWithFormat("V:[v0(30)]", views: iconImageView)
        
        self.addConstraint(NSLayoutConstraint(item: iconImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    }
    
    required init?(coder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
}
