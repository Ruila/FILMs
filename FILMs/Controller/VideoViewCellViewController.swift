//
//  VideoViewCellViewController.swift
//  FILMs
//
//  Created by Meng-Ru Lin on 2020/8/2.
//  Copyright © 2020 Meng-Ru Lin. All rights reserved.
//
import youtube_ios_player_helper
import UIKit
import PromiseKit
import SwiftyJSON
import Alamofire
import Kingfisher

class VideoViewCellViewController: UIViewController, YTPlayerViewDelegate {
    
    /*----first section---*/
    @IBOutlet weak var FirstSection: UIView!
    @IBOutlet var playerview: YTPlayerView!
    @IBOutlet weak var ViewCount: UILabel!
    @IBOutlet weak var VideoTitle: UILabel!
    @IBOutlet weak var Dislike: UIButton!
    @IBOutlet weak var Like: UIButton!
    
    /*----second section---*/
    @IBOutlet weak var SecondSection: UIView!
    @IBOutlet weak var ChannelTitle: UILabel!
    @IBOutlet weak var SubscriberCount: UILabel!
    @IBOutlet weak var ChannelImage: UIImageView!
    
    var apiKey = apiKK
    var videoId: String?
    var channel_ImageURL: String?
    var channel_Subscriber_Count: String?
    var channel_Title: String?
    
    
    let playvarsDic = ["controls": 1, "playsinline": 1, "autohide": 1, "showinfo": 1, "autoplay": 1, "modestbranding": 1]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showPlayer()
        showVideoDetail()
        LayerControl()
        getChannelInformation()
        // Do any additional setup after loading the view.
    }
    
    func LayerControl() {
        
        /*--addTopAndBottomBorders---*/
        let thickness: CGFloat = 1.0
        let bottomBorder = CALayer()
        let bottomBorder_two = CALayer()
        bottomBorder.frame = CGRect(x:0, y: self.FirstSection.frame.size.height - thickness, width: self.FirstSection.frame.size.width, height:thickness)
        bottomBorder.backgroundColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1).cgColor
        bottomBorder_two.frame = CGRect(x:0, y: self.SecondSection.frame.size.height - thickness, width: self.SecondSection.frame.size.width, height:thickness)
        bottomBorder_two.backgroundColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1).cgColor
        FirstSection.layer.addSublayer(bottomBorder)
        SecondSection.layer.addSublayer(bottomBorder_two)
        
        /*--corner rounds---*/
        self.ChannelImage.layer.cornerRadius = 20.0
        self.ChannelImage.clipsToBounds = true
    }
    
    func showPlayer(){
        /*---show youtube player---*/
        self.playerview.delegate = self
        self.playerview.load(withVideoId: self.videoId!, playerVars: self.playvarsDic)
    }
    
    func getChannelInformation(){
        
        self.SubscriberCount.text = self.channel_Subscriber_Count
        self.ChannelTitle.text = self.channel_Title
        
        let url = URL(string: self.channel_ImageURL ?? "nil")!
        self.ChannelImage.kf.setImage(with: url)
        {
            result in
            switch result {
            case .success( _): break
                
                
            case .failure(let error):
                print("Job failed==========: \(error.localizedDescription)")
            }
        }
    }
    func showVideoDetail(){
        firstly{
            getVideoDetail()
        }.done {  json in
            
            self.ViewCount.text = "觀看次數：" + json["items"][0]["statistics"]["viewCount"].stringValue
            self.VideoTitle.text = json["items"][0]["snippet"]["title"].stringValue
            //文字過長時的現實方式
            self.VideoTitle.lineBreakMode = NSLineBreakMode.byWordWrapping;
            //文字框是否允許多行（佈局相關）
            self.VideoTitle.numberOfLines = 0;
            
            self.Like.setTitle("Like：" + json["items"][0]["statistics"]["likeCount"].stringValue, for: .normal)
            self.Dislike.setTitle("Dislike：" + json["items"][0]["statistics"]["dislikeCount"].stringValue, for: .normal)
            
        }.catch{ error in
            print("error", error)
        }
    }
    
    func getVideoDetail()-> Promise<JSON>{
        
        return Promise { Resolver in
            guard let cpurl = URL(string:"https://www.googleapis.com/youtube/v3/videos?part=contentDetails&part=snippet&part=status&part=statistics&id=\(self.videoId ?? "nil")&key=\(self.apiKey)") else{return}
            
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
    
}
