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

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var tableViewVideos: UITableView!
    
    var videos = [VideosInfo]()
    var apiKey = apiKK
    var profileThumbnailsURL: String = ""
    var videoInfoDic = [String:String]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //        print("video count/////1111111", videos.count)
        return videos.count
        //        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ViewControllerTableViewCell
        
        let video: VideosInfo
        
        video = videos[indexPath.row]
       
        cell.VideoTitle.text = video.title
        cell.ChannelName.text =  video.channelName! + "・觀看次數："
        //文字過長時的現實方式
        cell.VideoTitle.lineBreakMode = NSLineBreakMode.byWordWrapping;
        //文字框是否允許多行（佈局相關）
        cell.VideoTitle.numberOfLines = 0;
        //        cell.textLabel?.text = cell.VideoDescription.text
        let url = URL(string: video.imageurl ?? "nil")!
        //        cell.VideoThumbnails.af.setImage(withURL: url)
        cell.VideoThumbnails.kf.setImage(with: url)
        
        let pturl = URL(string: video.profileThumbnails ?? "nil")
        cell.ProfileThumbnails.kf.setImage(with: pturl)
        
    
        
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
    
    func getVideoDetail(videoId: String) -> Dictionary<String, String>{
        guard let url = URL(string: "https://www.googleapis.com/youtube/v3/videos?part=snippet%2CcontentDetails%2Cstatistics&id=\(videoId)&key=\(apiKey)")
            else{
                let dicFail = ["FailMessage": "Bye"]
                return dicFail
        }
      
            self.videoInfoDic = [:] //clear for next video information
         

            AF.request(url).validate().responseJSON { (response) in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    //                print("\nJSONVIDEO///", json)
                    self.videoInfoDic["viewCount"] = json["items"][0]["statistics"]["viewCount"].stringValue
                    print("check222", self.videoInfoDic)
                    
                case .failure(let error):
                    print(error)
                }
            }
        
        print("check", self.videoInfoDic)
        return self.videoInfoDic
    }
    
    func getData(){
        //Channel Profile Information
        guard let cpurl = URL(string:"https://www.googleapis.com/youtube/v3/channels?part=contentDetails,snippet&id=UC6VSFaHYbR-bhNer7DXxGNQ&key=\(apiKey)") else{return}
        
        // Playlist Information
        guard let url = URL(string: "https://www.googleapis.com/youtube/v3/playlistItems?part=snippet,contentDetails,status&playlistId=UU6VSFaHYbR-bhNer7DXxGNQ&key=\(apiKey)&maxResults=3") else { return }
        
        DispatchQueue.global(qos: .userInitiated).sync{
            //channelProfile
            print("hi")
            AF.request(cpurl).validate().responseJSON { (response) in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    print("hello222")
                    self.profileThumbnailsURL = json["items"][0]["snippet"]["thumbnails"]["default"]["url"].stringValue
                    
                case .failure(let error):
                    print(error)
                }
            }
        }
        DispatchQueue.global(qos: .background).sync{
            //  catch playlist data
            print("hello")
            AF.request(url).validate().responseJSON { (response) in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    print("hello1111")
                    for i in 0..<json["items"].count{
                        self.videos.append(VideosInfo(
                            channelName: json["items"][i]["snippet"]["channelTitle"].stringValue,
                            imageurl: json["items"][i]["snippet"]["thumbnails"]["medium"]["url"].stringValue,
                            title: json["items"][i]["snippet"]["title"].stringValue,
                            profileThumbnails: self.profileThumbnailsURL,
                            videoId: json["items"][i]["contentDetails"]["videoId"].stringValue
                        ))
                        
                    }
                    self.tableViewVideos.reloadData()
                //                print("WWWWWWTTTTFFFFF")
                case .failure(let error):
                    print(error)
                }
                
            }
            
        }
    }
    
}

