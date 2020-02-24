//
//  HeadlineNewsAPI.swift
//  News
//
//  Created by QuangTH on 2/24/20.
//  Copyright © 2020 quangth. All rights reserved.
//

import Alamofire
import ObjectMapper

struct HeadlineNewsAPI: Request {
    
    let url = "/top-headlines"
    
    var endpoint: String {
        return Constants.API.apiVersion + url
    }
    
    typealias Output = CommonResponse<News>?
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.queryString
    }
    
    var params: Parameters {
        let dict: Parameters = [
            "language": "en",
            "apiKey": Constants.API.apiKey
        ]
        return dict
    }
    
    func decode(data: Any) -> Output {
        return Mapper<CommonResponse<News>>().map(JSONObject: data)
    }
}
