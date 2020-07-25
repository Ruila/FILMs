//
//  ViewController.swift
//  FILMs
//
//  Created by Meng-Ru Lin on 2020/7/23.
//  Copyright © 2020年 Meng-Ru Lin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var apiKey = apiKK
    
   

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        print("apiKK",apiKK)
        callAPI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
                print(filmsModel_d.items[0])
                
           
            
                
               
                
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

