//
//  News.swift
//  News
//
//  Created by QuangTH on 2/23/20.
//  Copyright © 2020 quangth. All rights reserved.
//

import ObjectMapper

struct News {
    
    var author: String?
    var title: String?
    var description: String?
    var originUrl: String?
    var imageUrl: String?
    var publishedDate: String?
    var content: String?
    
    init?(map: Map) {
        
    }
}

extension News: Mappable {
    mutating func mapping(map: Map) {
        author <- map["author"]
        title <- map["title"]
        description <- map["description"]
        originUrl <- map["url"]
        imageUrl <- map["urlToImage"]
        publishedDate <- map["publishedAt"]
        content <- map["content"]
    }
}
