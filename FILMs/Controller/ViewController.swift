//
//  ViewController.swift
//  FILMs
//
//  Created by Meng-Ru Lin on 2020/7/23.
//  Copyright © 2020年 Meng-Ru Lin. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON
import Kingfisher
import PromiseKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var tableViewVideos: UITableView!
    
    var videos = [VideosInfo]()
    var apiKey = apiKK
    var profileThumbnailsURL: String = ""
    var videoInfoDic = [String:String]()
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let controller = segue.destination as? VideoViewCellViewController
        
        controller?.textname = "Heolodofkd"
        
        
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
            case .success(let value):
                print("111111111:", value.image)
                
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
                    case .success(let value):
                        print("Task done for2222222:", value.image)
                        
                    case .failure(let error):
                        print("Job failed============: \(error.localizedDescription)")
                    }
                }
        
  
         return cell
        
       
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //        print("apiKK",apiKK)
        getData()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //    func getImage(videoUrl:String, cell:Any)->Promise<String>{
    //        return Promise{ Resolver in
    //
    //               let url = URL(string: videoUrl ?? "nil")!
    //            //        print("ggg", video.imageurl ?? "nil")
    //                    cell.VideoThumbnails.kf.setImage(with: url)
    //                    {
    //                        result in
    //                        switch result {
    //                        case .success(let value):
    //                            print("Task done for:", value.source)
    //                        case .failure(let error):
    //                            print("Job failed: \(error.localizedDescription)")
    //                        }
    //                    }
    //
    //        }
    //    }
    
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
                            videoViewCount: videoJson["items"][0]["statistics"]["viewCount"].stringValue
                        ))
                        
                        self.tableViewVideos.reloadData()
                    case .failure(let error):
                        print(error)
                    }
                }
                
            }
            
        }
    }
    
    
    func getChennelProfile()-> Promise<JSON>{
        
        return Promise { Resolver in
            guard let cpurl = URL(string:"https://www.googleapis.com/youtube/v3/channels?part=contentDetails,snippet&id=UC6VSFaHYbR-bhNer7DXxGNQ&key=\(apiKey)") else{return}
            
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
            guard let url = URL(string: "https://www.googleapis.com/youtube/v3/playlistItems?part=snippet,contentDetails,status&playlistId=UU6VSFaHYbR-bhNer7DXxGNQ&key=\(apiKey)&maxResults=3") else { return }
            
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

