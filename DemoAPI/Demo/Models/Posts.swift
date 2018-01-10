//
//  Posts.swift
//  Demo
//
//  Created by Ketan on 1/9/18.
//  Copyright © 2018 Ketan Saini. All rights reserved.
//

import Foundation
import ObjectMapper

class Posts: Mappable {
    var id: Int?
    var userId: Int?
    var title: String?
    var body: String?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        userId <- map["userId"]
        title <- map["title"]
        body <- map["body"]
    }
}
