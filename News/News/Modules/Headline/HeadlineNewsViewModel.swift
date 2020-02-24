//
//  HeadlineNewsViewModel.swift
//  News
//
//  Created by QuangTH on 2/24/20.
//  Copyright © 2020 quangth. All rights reserved.
//

import RxSwift
import RxCocoa

class HeadlineNewsViewModel: BaseViewModel {
    
    let newsList = BehaviorRelay<[News]>(value: [])
    
    private let useCase = GetTopHeadlinesUseCase()
    
    func getTopHeadlineNews() {
        useCase
            .execute(input: ParamNone())
            .subscribe(onNext: { result in
                guard let newsList = result else { return }
                self.newsList.accept(newsList)
            }, onError: { _ in
            }).disposed(by: bag)
    }
}
