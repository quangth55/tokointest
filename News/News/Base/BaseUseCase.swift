//
//  BaseUseCase.swift
//  News
//
//  Created by QuangTH on 2/23/20.
//  Copyright © 2020 quangth. All rights reserved.
//

import RxSwift

protocol BaseUseCase {
    associatedtype Output
    associatedtype Input
    func run(input: Input) -> Observable<Output>
}

extension BaseUseCase {
    func execute(input: Input) -> Observable<Output> {
        return self.run(input: input)
            .observeOn(MainScheduler.instance)
            .do(onNext: nil, onError: { _ in
            }, onCompleted: {
            }, onSubscribe: nil, onSubscribed: nil, onDispose: nil)
    }
}

struct ParamNone {
    
}
