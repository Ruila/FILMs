//
//  UIViewExtension.swift
//  FILMs
//
//  Created by Meng-Ru Lin on 2020/8/13.
//  Copyright © 2020 Meng-Ru Lin. All rights reserved.
//

import UIKit

extension UIView {
    func addConstraintsWithFormat(_ format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDictionary))
    }
}
