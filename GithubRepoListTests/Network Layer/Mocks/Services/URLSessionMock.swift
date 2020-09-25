//
//  URLSessionMock.swift
//  GithubRepoListTests
//
//  Created by Marcelo Hammes on 25/09/20.
//  Copyright © 2020 Marcelo Hammes. All rights reserved.
//

import Foundation
@testable import GithubRepoList

final class URLSessionMock: URLSessionProtocol {
    private(set) var dataTaskCalled = false
    private(set) var lastURL: URL?
    private let dataTask: URLSessionDataTaskProtocol
    private(set) var isHttpBodyEmpty = true
    
    var service: ServiceMock!
    
    init(dataTask: URLSessionDataTaskProtocol) {
        self.dataTask = dataTask
    }
    
    func dataTask(request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol {
        dataTaskCalled = true
        lastURL = request.url
        isHttpBodyEmpty = request.httpBody == nil
        
        switch service {
        case .jsonResponseWith200?:
            let model = ModelMock(test: "test")
            let data = try? JSONEncoder().encode(model)
            let response = HTTPURLResponse(url: service.baseURL, statusCode: 200, httpVersion: nil, headerFields: nil)
            completionHandler(data, response, nil)
        case .jsonResponseWithURLParametersWith200:
            let model = ModelMock(test: "test")
            let data = try? JSONEncoder().encode(model)
            let response = HTTPURLResponse(url: service.baseURL, statusCode: 200, httpVersion: nil, headerFields: nil)
            completionHandler(data, response, nil)
        case .errorWith400:
            let response = HTTPURLResponse(url: service.baseURL, statusCode: 400, httpVersion: nil, headerFields: nil)
            completionHandler(nil, response, nil)
        case .errorWith500:
            let response = HTTPURLResponse(url: service.baseURL, statusCode: 500, httpVersion: nil, headerFields: nil)
            completionHandler(nil, response, nil)
        default: break
        }
        
        return dataTask
    }
}
