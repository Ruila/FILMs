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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        print("video count/////1111111", videos.count)
        return videos.count
        //        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ViewControllerTableViewCell
        
        let video: VideosInfo
       
        video = videos[indexPath.row]
//        print("---cell.VideoTitle.text---", cell.VideoTitle.text as Any)
//        print("---video.imageurl---", video.imageurl ?? "url")
//           print("---video.text---", video.title ?? "url")
        cell.VideoTitle.text = video.title
        //文字過長時的現實方式
        cell.VideoTitle.lineBreakMode = NSLineBreakMode.byWordWrapping;
        //文字框是否允許多行（佈局相關）
        cell.VideoTitle.numberOfLines = 0;
        //        cell.textLabel?.text = cell.VideoDescription.text
        let url = URL(string: video.imageurl ?? "nil")!
//        cell.VideoThumbnails.af.setImage(withURL: url)
         cell.VideoThumbnails.kf.setImage(with: url)
//                AF.request(video.imageurl as! URLRequestConvertible).responseImage { (response) in
//
//                    switch response.result {
//                    case .success(let value):
//
//
//                        cell.VideoImage.image = value as? UIImage
//                    case .failure(let error):
//                        print(error)
//                    }
//
//                }
            
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
    
    
    func getData(){
        var profileThumbnailsURL: String = ""
      
        //Channel Profile Information
         guard let cpurl = URL(string:"https://www.googleapis.com/youtube/v3/channels?part=contentDetails,snippet&id=UC6VSFaHYbR-bhNer7DXxGNQ&key=\(apiKey)") else{return}
        
        // Playlist Information
        guard let url = URL(string: "https://www.googleapis.com/youtube/v3/playlistItems?part=snippet,contentDetails,status&playlistId=UU6VSFaHYbR-bhNer7DXxGNQ&key=\(apiKey)&maxResults=10") else { return }
        
        DispatchQueue.global(qos: .userInitiated).sync{
            print("I'm an one")
            //channelProfile
            AF.request(cpurl).validate().responseJSON { (response) in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    profileThumbnailsURL = json["items"][0]["snippet"]["thumbnails"]["default"]["url"].stringValue
                    print("--------profile========", json["items"][0]["snippet"]["thumbnails"]["default"]["url"].stringValue)

                case .failure(let error):
                    print(error)
                }
                
            }
            
        }
        
        print("I'm an two")
        
        DispatchQueue.global(qos: .background).sync{
            print("I'm an three")
            
            print("profileThumbnailsURL", profileThumbnailsURL)
                   //  catch playlist data
            AF.request(url).validate().responseJSON { (response) in
                    switch response.result {
                    case .success(let value):
                        let json = JSON(value)
                        
                        for i in 0..<json["items"].count{
                            /* Type problem   json ro string **/
                            print("=====url====", json["items"][i]["snippet"]["thumbnails"]["medium"]["url"].stringValue)
                            self.videos.append(VideosInfo(
                                imageurl: json["items"][i]["snippet"]["thumbnails"]["medium"]["url"].stringValue,
                                title: json["items"][i]["snippet"]["title"].stringValue
                            ))

                        }
                        self.tableViewVideos.reloadData()
                    //                print("WWWWWWTTTTFFFFF")
                    case .failure(let error):
                        print(error)
                    }
                    
                }
            print("I'm an four")
        }
        
       
    
    }
    
    
    private func callAPI() {
        // 根據網站的 Request tab info 我們拼出請求的網址
        let url = URL(string: "https://www.googleapis.com/youtube/v3/playlistItems?part=snippet,contentDetails,status&playlistId=UU6VSFaHYbR-bhNer7DXxGNQ&key=\(apiKey)&maxResults=10")!
        
        // 將網址組成一個 URLRequest
        var request = URLRequest(url: url)
        
        // 設置請求的方法為 GET
        request.httpMethod = "GET"
        
        // 建立 URLSession
        let session = URLSession.shared
        
        // 使用 sesstion + request 組成一個 task
        // 並設置好，當收到回應時，需要處理的動作
        let dataTask = session.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            // 這邊是收到回應時會執行的 code
            print("0")
            // 因為 data 是 optional，有可能請求失敗，導致 data 是空的
            // 如果是空的，我們直接 return，不做接下來的動作
            guard let data = data else {
                return
            }
            
            do {
                print("1")
                
                // 使用 JSONDecoder 去解開 data
                let filmsModel_d = try JSONDecoder().decode(filmsModel.self, from: data)
                //                print(filmsModel_d)
                let json = JSON(filmsModel_d)
                print(json)
                
                
            } catch {
                
                print(error)
            }
            
        })
        
        // 啟動 task
        dataTask.resume()
    }
    
    private func showFilmList(data: Any) {
        
    }
    
    
    
    
    
    
    
    
}

