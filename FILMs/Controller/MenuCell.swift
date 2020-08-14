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
        iv.image = UIImage(named: "home")
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("ffff")
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    override var isHighlighted: Bool{
        didSet {
            print("123")
        }
    }
    
    
    
    
    
    
}
