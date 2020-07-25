//
//  filmsModel.swift
//  FILMs
//
//  Created by Meng-Ru Lin on 2020/7/24.
//  Copyright © 2020年 Meng-Ru Lin. All rights reserved.
//

import Foundation

struct filmsModel: Decodable{
    let nextPageToken: String
    let items: [List]
    let pageInfo: pageInfo_content
    struct List: Decodable{
        let id:String
        let snippet: snippet_content
        let contentDetails: contentDetails_content
        let status: status_content
        
        struct snippet_content:Decodable{
            let publishedAt: String
            let channelId: String
            let title: String
            let description: String
            let thumbnails: thumbnails_content
            let channelTitle: String
            let playlistId: String
            let position: Int
            
            struct thumbnails_content: Decodable{
                let high: high_content
                
                struct high_content: Decodable {
                    let url: String
                    let width: Int
                    let height: Int
                }
            }
        }
        
        struct contentDetails_content: Decodable{
            let videoId: String
            let videoPublishedAt: String
        }
        
        struct status_content: Decodable{
            let privacyStatus: String
        }
    }
    
    struct pageInfo_content: Decodable{
        let totalResults: Int
        let resultsPerPage: Int
    }
}


