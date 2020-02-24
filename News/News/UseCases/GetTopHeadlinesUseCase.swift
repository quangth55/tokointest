//
//  GetTopHeadlinesUseCase.swift
//  News
//
//  Created by QuangTH on 2/24/20.
//  Copyright © 2020 quangth. All rights reserved.
//

import RxSwift

class GetTopHeadlinesUseCase: BaseUseCase {
    
    typealias Output = [News]?
    typealias Input = ParamNone
    
    private let repository: HeadlineNewsRepository
    
    init() {
        repository = HeadlineNewsRepository()
    }
    
    func run(input: Input) -> Observable<Output> {
        return repository.getTopHeadlineNews()
    }
}
