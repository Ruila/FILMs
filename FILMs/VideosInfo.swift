//
//  VideosInfo.swift
//  FILMs
//
//  Created by Meng-Ru Lin on 2020/7/28.
//  Copyright © 2020 Meng-Ru Lin. All rights reserved.
//

class VideosInfo {
    var imageurl: String?
    var title: String?
    var profileThumbnails: String?
    var channelName: String?
    
    init(channelName: String?, imageurl: String?, title: String?, profileThumbnails: String?){
        self.imageurl = imageurl
        self.title = title
        self.profileThumbnails = profileThumbnails
        self.channelName = channelName
    }
    
//    init(title: String?){
//        self.title = title
//    }
}
