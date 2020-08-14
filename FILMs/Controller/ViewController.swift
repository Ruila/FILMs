//
//  ViewController.swift
//  FILMs
//
//  Created by Meng-Ru Lin on 2020/7/23.
//  Copyright © 2020年 Meng-Ru Lin. All rights reserved.
//

import UIKit
import Alamofire

import SwiftyJSON
import Kingfisher
import PromiseKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet weak var CollectionIconBox: UICollectionView!
    @IBOutlet weak var tableViewVideos: UITableView!
    //    @IBOutlet weak var NavigationTitle: UINavigationItem!
    
    var videos = [VideosInfo]()
    var apiKey = apiKK
    let MenuBarImageNames = ["home", "fire", "feed", "user"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //        print("apiKK",apiKK)
        getData()
        setIconBox()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let cell = collectionView.cellForItem(at: indexPath)
//        print("selected cell", indexPath)
//        cell?.contentView
//    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collecCell", for: indexPath)as! MenuCell
        
   
//        let imageView: UIImageView = {
//            let iv = UIImageView()
//            iv.image = UIImage(named: MenuBarImageNames[indexPath.item])?.withRenderingMode(.alwaysTemplate)
//            iv.tintColor = UIColor(red: 91/255, green: 14/255, blue: 13/255, alpha: 1)
//            return iv
//        }()
//
//
//
//        cell.addSubview(imageView)
//        cell.addConstraintsWithFormat("H:[v0(25)]", views: imageView)
//        cell.addConstraintsWithFormat("V:[v0(25)]", views: imageView)
//        cell.addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: cell, attribute: .centerX, multiplier: 1, constant: 0))
//        cell.addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerY, relatedBy: .equal, toItem: cell, attribute: .centerY, multiplier: 1, constant: 0))
//
//        cell.tintColor = UIColor(red: 91/255, green: 14/255, blue: 13/255, alpha: 1)
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: self.CollectionIconBox.frame.width / 4, height: CollectionIconBox.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func setIconBox(){
        CollectionIconBox.delegate = self
        CollectionIconBox.dataSource = self
        //         self.CollectionIconBox.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let video: VideosInfo
        video = videos[indexPath.row]
        //        print("i am choosed", video.title!)
        if let controller = storyboard?.instantiateViewController(withIdentifier:"showVideoPage") as? VideoViewCellViewController{
            controller.videoId = video.videoId!
            controller.channel_ImageURL = video.profileThumbnails!
            controller.channel_Subscriber_Count = video.channelSubscriberCount!
            controller.channel_Title = video.channelName!
            present(controller, animated: true, completion: nil)
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return videos.count
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ViewControllerTableViewCell
        
        let video: VideosInfo
        
        video = videos[indexPath.row]
        cell.VideoTitle.text = video.title
        
        cell.ChannelName.text =  video.channelName! + "・觀看次數：" + video.videoViewCount!
        
        
        //文字過長時的現實方式
        cell.VideoTitle.lineBreakMode = NSLineBreakMode.byWordWrapping;
        //文字框是否允許多行（佈局相關）
        cell.VideoTitle.numberOfLines = 0;
        
        let url = URL(string: video.imageurl ?? "nil")!
        
        cell.VideoThumbnails.kf.setImage(with: url)
        {
            result in
            switch result {
            case .success( _): break
                //                print("111111111:", value.image)
                
            case .failure(let error):
                print("Job failed==========: \(error.localizedDescription)")
            }
        }
        let pturl = URL(string: video.profileThumbnails ?? "nil")
        //                print("pturl", pturl)
        cell.ProfileThumbnails.kf.setImage(with: pturl)
        {
            result in
            switch result {
            case .success( _): break
                //                print("Task done for2222222:", value.image)
                
            case .failure(let error):
                print("Job failed============: \(error.localizedDescription)")
            }
        }
        
        
        return cell
        
        
    }
    
    
    
    func getData(){
        firstly{
            when(fulfilled: self.getChennelProfile(), self.getPlaylistData())
        }.done { json1, json2 in
            for i in 0..<json2["items"].count{
                guard let videourl = URL(string: "https://www.googleapis.com/youtube/v3/videos?part=snippet%2CcontentDetails%2Cstatistics&id=\(json2["items"][i]["contentDetails"]["videoId"].stringValue )&key=\(self.apiKey)")
                    else{return}
                
                
                AF.request(videourl).validate().responseJSON { (response) in
                    switch response.result {
                    case .success(let value):
                        let videoJson = JSON(value)
                        
                        self.videos.append(VideosInfo(
                            channelName: json2["items"][i]["snippet"]["channelTitle"].stringValue,
                            imageurl: json2["items"][i]["snippet"]["thumbnails"]["medium"]["url"].stringValue,
                            title: json2["items"][i]["snippet"]["title"].stringValue,
                            profileThumbnails: json1["items"][0]["snippet"]["thumbnails"]["medium"]["url"].stringValue,
                            videoId: json2["items"][i]["contentDetails"]["videoId"].stringValue,
                            videoViewCount: videoJson["items"][0]["statistics"]["viewCount"].stringValue,
                            channelSubscriberCount: json1["items"][0]["statistics"]["subscriberCount"].stringValue
                        ))
                        
                        self.tableViewVideos.reloadData()
                    case .failure(let error):
                        print(error)
                    }
                }
            }
        }.catch{ error in
            print("error", error)
        }
    }
    
    
    func getChennelProfile()-> Promise<JSON>{
        
        return Promise { Resolver in
            guard let cpurl = URL(string:"https://www.googleapis.com/youtube/v3/channels?part=contentDetails,snippet,statistics&id=UC6VSFaHYbR-bhNer7DXxGNQ&key=\(apiKey)") else{return}
            
            AF.request(cpurl).validate().responseJSON { (response) in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    
                    Resolver.fulfill(json)
                case .failure(let error):
                    print(error)
                }
            }
            
        }
    }
    
    func getPlaylistData()-> Promise<JSON>{
        return Promise { Resolver in
            guard let url = URL(string: "https://www.googleapis.com/youtube/v3/playlistItems?part=snippet,contentDetails,status&playlistId=UU6VSFaHYbR-bhNer7DXxGNQ&key=\(apiKey)&maxResults=10") else { return }
            
            AF.request(url).validate().responseJSON { (response) in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    Resolver.fulfill(json)
                    
                    
                case .failure(let error):
                    print(error)
                }
                
            }
            
        }
    }
    
}

