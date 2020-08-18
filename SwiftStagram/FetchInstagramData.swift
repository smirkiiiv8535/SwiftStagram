//
//  fetchInstagramData.swift
//  SwiftStagram
//
//  Created by 林祐辰 on 2020/8/16.
//

import Foundation
import UIKit

// FetchInstagramData.Graphql.UserData

struct FetchInstagramData:Codable{
    let graphql :Graphql

    struct Graphql: Codable {
        let user: UserData
    
    struct UserData:Codable{
        let edge_followed_by : CountHelper
        let edge_follow : CountHelper
        let full_name :String
        let username:String
        let profile_pic_url: URL

              
          let edge_owner_to_timeline_media : Edge_owner_to_timeline_media
        
        
           struct Edge_owner_to_timeline_media :Codable{
              let count : Int
              var page_info : PageInfo
              let edges : [Edges]
            
            struct Edges:Codable {
                let node:Node
                struct Node:Codable {
                    let shortCode : String?
                    let display_url :URL?
                    let is_video:Bool?
                    let has_audio:Bool?
                    let video_url:String?
                    let edge_media_to_caption :Edge_media_to_Caption?
                    let text : String?
                    let edge_liked_by:CountHelper?
                    let taken_at_timestamp :Double?
                    let thumbnail_src:URL?
                    struct Edge_media_to_Caption:Codable{
                        let edges : [Edges]
                    }
                    
                }
            }
            
            struct PageInfo:Codable{
                let has_next_page :Bool
                let end_cursor: String?
            }
            
        }

        
        struct CountHelper: Codable{
            let count: Int
        }
    }
    
  }
}




