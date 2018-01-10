//
//  User.swift
//  Demo
//
//  Created by Ketan on 1/9/18.
//  Copyright © 2018 Ketan Saini. All rights reserved.
//

import Foundation
import ObjectMapper

class User: Mappable {
    var id: Int?
    var name: String?
    var username: String?
    var email: String?
    var phone: String?
    var website: String?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        username <- map["username"]
        email <- map["email"]
        phone <- map["phone"]
        website <- map["website"]
    }
}

