//
//  URLSessionDataTaskMock.swift
//  GithubRepoListTests
//
//  Created by Marcelo Hammes on 25/09/20.
//  Copyright © 2020 Marcelo Hammes. All rights reserved.
//

import Foundation
@testable import GithubRepoList

final class URLSessionDataTaskMock: URLSessionDataTaskProtocol {

    var isResumeCalled = false
    
    func resume() {
        isResumeCalled = true
    }
}
