//
//  MessageBoardViewController.swift
//  FILMs
//
//  Created by Meng-Ru Lin on 2020/8/12.
//  Copyright © 2020 Meng-Ru Lin. All rights reserved.
//

import UIKit

class MessageBoardViewController: UIViewController {
    
    let emptyView = UIView()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.black
        return cv
    }()
    
    func showMessageBoard() {
        if let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first{
            
            
            emptyView.backgroundColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 0)
            emptyView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(closeMessageBoard)))
            
            window.addSubview(emptyView)
            window.addSubview(collectionView)
           
            
            emptyView.frame = window.frame
            emptyView.alpha = 0
            
            let height: CGFloat = 200
            let y = window.frame.height - height
            collectionView.frame = CGRect(x: 0,
                                          y: window.frame.height,
                                          width: window.frame.width,
                                          height: height)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1,options: .curveEaseOut, animations: {
                self.emptyView.alpha = 1
                self.collectionView.frame = CGRect(x: 0,
                                                   y: y,
                                                   width: window.frame.width,
                                                   height: window.frame.height)
            }, completion: nil)
            
        }
    }
    
    @objc func closeMessageBoard() {
        if let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first{
            print("close")
            emptyView.alpha = 0
            collectionView.frame = CGRect(x: 0,
                                          y: window.frame.height,
                                          width: window.frame.width,
                                          height: 200)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
