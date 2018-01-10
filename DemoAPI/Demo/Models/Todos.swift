//
//  Todos.swift
//  Demo
//
//  Created by Ketan on 1/9/18.
//  Copyright © 2018 Ketan Saini. All rights reserved.
//

import Foundation
import ObjectMapper

class Todos: Mappable {
    var id: Int?
    var userId: Int?
    var title: String?
    var completed: Bool?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        userId <- map["userId"]
        title <- map["title"]
        completed <- map["completed"]
    }
}
