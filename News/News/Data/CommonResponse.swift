//
//  CommonResponse.swift
//  News
//
//  Created by QuangTH on 2/23/20.
//  Copyright © 2020 quangth. All rights reserved.
//

import ObjectMapper

struct CommonResponse<T: Mappable> {
    
    var status: String?
    var totalResults: Int?
    var data: [T]?
    
    init?(map: Map) {
        
    }
}

extension CommonResponse: Mappable {
    
    mutating func mapping(map: Map) {
        status <- map["status"]
        data <- map["articles"]
        totalResults <- map["totalResults"]
    }
}
