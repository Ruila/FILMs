//
//  MenuCell.swift
//  FILMs
//
//  Created by Meng-Ru Lin on 2020/8/14.
//  Copyright © 2020 Meng-Ru Lin. All rights reserved.
//

import UIKit

class MenuCell: UICollectionViewCell {
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "home")?.withRenderingMode(.alwaysTemplate)
        iv.tintColor = UIColor(red: 91/255, green: 14/255, blue: 13/255, alpha: 1)
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        
        
        self.addSubview(imageView)
        self.addConstraintsWithFormat("H:[v0(25)]", views: imageView)
        self.addConstraintsWithFormat("V:[v0(25)]", views: imageView)
        self.addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        
        self.tintColor = UIColor(red: 91/255, green: 14/255, blue: 13/255, alpha: 1)
    }
    
    
    override var isHighlighted: Bool{
        didSet {
            imageView.tintColor = self.isHighlighted ? UIColor.white : UIColor(red: 91/255, green: 14/255, blue: 13/255, alpha: 1)
        }
    }
    
    override var isSelected: Bool{
        didSet {
            imageView.tintColor = self.isSelected ? UIColor.white : UIColor(red: 91/255, green: 14/255, blue: 13/255, alpha: 1)
        }
    }
    
    
    
    
}
