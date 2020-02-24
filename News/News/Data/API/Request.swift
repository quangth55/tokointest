//
//  Request.swift
//  News
//
//  Created by QuangTH on 2/23/20.
//  Copyright © 2020 quangth. All rights reserved.
//

import UIKit
import RxSwift
import Alamofire

protocol Request: URLRequestConvertible {
    
    associatedtype Output
    
    var basePath: String { get }
    
    var endpoint: String { get }
    
    var httpMethod: HTTPMethod { get }
            
    var params: Parameters { get }
    
    var parameterEncoding: ParameterEncoding { get }
                    
    func execute() -> Observable<Output>
    
    func decode(data: Any) -> Output
    
    func connectWithRequest(urlRequest: URLRequest, complete: @escaping (DataResponse<Data>) -> Void) -> DataRequest
}

extension Request {
    
    var basePath: String {
        return Constants.API.baseUrl
    }
    
    var params: Parameters {
        return [:]
    }
    
    var parameterEncoding: ParameterEncoding {
        return JSONEncoding.default
    }
    
    var urlPath: String {
        return basePath + endpoint
    }
    
    var url: URL {
        return URL(string: urlPath)!
    }
    
    @discardableResult
    func execute() -> Observable<Output> {
        return toObservable()
    }

    private func toObservable() -> Observable<Output> {
        
        return Observable.create { observer in
            guard let urlRequest = try? self.asURLRequest() else {
                
                return Disposables.create()
            }
            let connect = self.connectWithRequest(urlRequest: urlRequest, complete: { response in
                print(response)
                do {
                    guard let dataResponse = response.data,
                        let json = try JSONSerialization.jsonObject(with: dataResponse, options: .allowFragments) as? [String: Any] else {
                            
                            return
                    }
                   
                    observer.onNext(self.decode(data: json))
                    observer.onCompleted()
                    
                } catch {
                    
                }
                
            })
            return Disposables.create {
                connect.cancel()
            }
        }
    }
    
    func connectWithRequest(urlRequest: URLRequest, complete: @escaping (DataResponse<Data>) -> Void) -> DataRequest {
        
        let sessionManager = Alamofire.SessionManager.default
        let request = sessionManager.request(urlRequest)
        request.responseData { data in
            complete(data)
        }
        return request
    }

    fileprivate func buildURLRequest() throws -> URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod.rawValue
        urlRequest = try parameterEncoding.encode(urlRequest, with: params)
        return urlRequest
    }
    
}

// MARK: - Conform URLConvertible from Alamofire
extension Request {
    
    func asURLRequest() throws -> URLRequest {
        return try buildURLRequest()
    }
}
