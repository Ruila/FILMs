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

class VideoViewCellViewController: UIViewController, YTPlayerViewDelegate {
    
    
    @IBOutlet var playerview: YTPlayerView!
    @IBOutlet weak var ViewCount: UILabel!
    @IBOutlet weak var VideoTitle: UILabel!
    
    @IBOutlet weak var Dislike: UIButton!
    @IBOutlet weak var Like: UIButton!
    
    var apiKey = apiKK
    var videoId: String?
    
    
    
    let playvarsDic = ["controls": 1, "playsinline": 1, "autohide": 1, "showinfo": 1, "autoplay": 1, "modestbranding": 1]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Display()
        
        // Do any additional setup after loading the view.
    }
    
    func Display(){
        
        firstly{
            getVideoDetail()
        }.done {  json in
            self.playerview.delegate = self
            self.playerview.load(withVideoId: self.videoId!, playerVars: self.playvarsDic)
            self.ViewCount.text = "觀看次數：" + json["items"][0]["statistics"]["viewCount"].stringValue
            self.VideoTitle.text = json["items"][0]["snippet"]["title"].stringValue
            //文字過長時的現實方式
            self.VideoTitle.lineBreakMode = NSLineBreakMode.byWordWrapping;
            //文字框是否允許多行（佈局相關）
            self.VideoTitle.numberOfLines = 0;
            
            self.Like.setTitle("Like：" + json["items"][0]["statistics"]["likeCount"].stringValue, for: .normal)
            self.Dislike.setTitle("Like：" + json["items"][0]["statistics"]["dislikeCount"].stringValue, for: .normal)
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
