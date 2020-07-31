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
    
    init(imageurl: String?, title: String?, profileThumbnails: String?){
        self.imageurl = imageurl
        self.title = title
        self.profileThumbnails = profileThumbnails
    }
    
//    init(title: String?){
//        self.title = title
//    }
}
