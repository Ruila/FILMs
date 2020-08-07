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
    var videoId: String?
    
    let playvarsDic = ["controls": 1, "playsinline": 1, "autohide": 1, "showinfo": 1, "autoplay": 0, "modestbranding": 1]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Display()
       
        // Do any additional setup after loading the view.
    }
    
    func Display(){
        playerview.delegate = self
        playerview.load(withVideoId: self.videoId!, playerVars: playvarsDic)
    }
    
}
