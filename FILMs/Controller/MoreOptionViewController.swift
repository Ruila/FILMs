//
//  MoreOptionViewController.swift
//  FILMs
//
//  Created by Meng-Ru Lin on 2020/8/15.
//  Copyright © 2020 Meng-Ru Lin. All rights reserved.
//

import UIKit

class Setting: NSObject{
    let name: String
    let imageName: String
    
    init(name: String, imageName: String) {
        self.name = name
        self.imageName = imageName
    }
    
}

class MoreOptionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellId"
    let cellHeight = 50
    let emptyView = UIView()
    
    let settings: [Setting] = {
        return [Setting(name: "Settings", imageName: "setting"),Setting(name: "Terms & privacy policy", imageName: "password"),Setting(name: "Send feedback", imageName: "feedback"),Setting(name: "Help", imageName: "help"),Setting(name: "Switch Account", imageName: "user-1"),Setting(name: "Cancel", imageName: "close")]
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        return cv
    }()
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?){
        super.init(nibName: nil, bundle: nil)
        print("override init")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(SettingCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return settings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)as! SettingCell
        
        let setting = settings[indexPath.item]
        cell.setting = setting
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: CGFloat(self.cellHeight))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    func show(){
        if let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first{
            
            
            emptyView.backgroundColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 0)
            emptyView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(close)))
            
            window.addSubview(emptyView)
            window.addSubview(collectionView)
            
            
            emptyView.frame = window.frame
            emptyView.alpha = 0
            
            let height: CGFloat = CGFloat(settings.count * cellHeight + 50)
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
    
    @objc func close() {
        if let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first{
            print("close")
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1,options: .curveEaseOut, animations: {
                self.emptyView.alpha = 0
                self.collectionView.frame = CGRect(x: 0,
                                                   y: window.frame.height,
                                                   width: window.frame.width,
                                                   height: window.frame.height)
            }, completion: nil)
            
        }
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
