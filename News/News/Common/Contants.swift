//
//  Contants.swift
//  News
//
//  Created by QuangTH on 2/23/20.
//  Copyright © 2020 quangth. All rights reserved.
//

import UIKit

enum Constants {
    enum API {
        static let baseUrl = "http://newsapi.org"
        static let apiVersion = "/v2"
        static let apiKey = "eded75ec36044ad2a17e6d39bdcc07db"
    }
    
    enum Screen {
        static var width: CGFloat {
            return UIScreen.main.bounds.width
        }
        
        static var height: CGFloat {
            return UIScreen.main.bounds.height
        }
    }
}
