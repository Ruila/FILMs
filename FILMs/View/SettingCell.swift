//
//  SettingCell.swift
//  FILMs
//
//  Created by Meng-Ru Lin on 2020/8/15.
//  Copyright © 2020 Meng-Ru Lin. All rights reserved.
//

import UIKit

class SettingCell: UICollectionViewCell {
    override init(frame: CGRect) {
           super.init(frame: frame)
           print("bleeeee")
        backgroundColor = UIColor.blue
       }
    
    required init?(coder: NSCoder) {
         print("gsdgsgsdg")
        fatalError("init(coder:) has not been implemented")
    }
}
