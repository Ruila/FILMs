//
//  VideoViewCellViewController.swift
//  FILMs
//
//  Created by Meng-Ru Lin on 2020/8/2.
//  Copyright © 2020 Meng-Ru Lin. All rights reserved.
//

import UIKit

class VideoViewCellViewController: UIViewController {
    
    @IBOutlet weak var textLabel: UILabel!
    
    var textname: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Display()
        // Do any additional setup after loading the view.
    }
    
    func Display(){
        if let name = textname{
            textLabel.text = name
        }
    }
    
}
