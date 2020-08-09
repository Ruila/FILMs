//
//  VideoViewCellViewController.swift
//  FILMs
//
//  Created by Meng-Ru Lin on 2020/8/2.
//  Copyright © 2020 Meng-Ru Lin. All rights reserved.
//
import youtube_ios_player_helper
import UIKit

class VideoViewCellViewController: UIViewController, YTPlayerViewDelegate {
    
    
    @IBOutlet var playerview: YTPlayerView!
    @IBOutlet weak var ViewCount: UILabel!
    @IBOutlet weak var VideoTitle: UILabel!
    
    var videoId: String?
    var videoTitle:String?
    var viewCount: String?
    
    
    let playvarsDic = ["controls": 1, "playsinline": 1, "autohide": 1, "showinfo": 1, "autoplay": 1, "modestbranding": 1]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Display()
        
        // Do any additional setup after loading the view.
    }
    
    func Display(){
        playerview.delegate = self
        playerview.load(withVideoId: self.videoId!, playerVars: playvarsDic)
        ViewCount.text = "觀看次數：" + self.viewCount!
        VideoTitle.text = self.videoTitle
        //文字過長時的現實方式
        VideoTitle.lineBreakMode = NSLineBreakMode.byWordWrapping;
        //文字框是否允許多行（佈局相關）
        VideoTitle.numberOfLines = 0;
    }
    
}
