//
//  Photos.swift
//  Demo
//
//  Created by Ketan on 1/9/18.
//  Copyright © 2018 Ketan Saini. All rights reserved.
//

import Foundation
import ObjectMapper

class Photos: Mappable {
    var id: Int?
    var albumId: Int?
    var title: String?
    var url: String?
    var thumbnailUrl: String?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        albumId <- map["albumId"]
        title <- map["title"]
        url <- map["url"]
        thumbnailUrl <- map["thumbnailUrl"]
    }
}
