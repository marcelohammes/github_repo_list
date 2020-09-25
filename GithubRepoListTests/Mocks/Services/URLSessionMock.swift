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
    private let dataTask: URLSessionDataTaskProtocol
    
    init(dataTask: URLSessionDataTaskProtocol) {
        self.dataTask = dataTask
    }

    func dataTask(request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol {
        dataTaskCalled = true

        return dataTask
    }
}
