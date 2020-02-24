//
//  HeadlineNewsRepository.swift
//  News
//
//  Created by QuangTH on 2/24/20.
//  Copyright © 2020 quangth. All rights reserved.
//

import RxSwift

class HeadlineNewsRepository {
    
    func getTopHeadlineNews() -> Observable<[News]?> {
        return HeadlineNewsAPI().execute().map { response -> [News]? in
                return response?.data
        }
    }
}
