//
//  URLSessionDataTaskProtocol.swift
//  GithubRepoList
//
//  Created by Marcelo Hammes on 25/09/20.
//  Copyright © 2020 Marcelo Hammes. All rights reserved.
//

import Foundation

protocol URLSessionDataTaskProtocol: class {
    func resume()
}

extension URLSessionDataTask: URLSessionDataTaskProtocol {}
