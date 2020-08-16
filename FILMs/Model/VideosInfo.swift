//
//  VideosInfo.swift
//  FILMs
//
//  Created by Meng-Ru Lin on 2020/7/28.
//  Copyright © 2020 Meng-Ru Lin. All rights reserved.
//

import UIKit

class VideosInfo: NSObject {
    var imageurl: String?
    var title: String?
    var profileThumbnails: String?
    var channelName: String?
    var channelSubscriberCount: String?
    var videoId: String?
    var videoViewCount: String?
    
    init(channelName: String?, imageurl: String?, title: String?, profileThumbnails: String?, videoId: String?, videoViewCount: String?, channelSubscriberCount: String?){
        self.imageurl = imageurl
        self.title = title
        self.profileThumbnails = profileThumbnails
        self.channelName = channelName
        self.videoId = videoId
        self.videoViewCount = videoViewCount
        self.channelSubscriberCount = channelSubscriberCount
    }
}
