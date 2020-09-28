//
//  NetworkResponse.swift
//  GithubRepoList
//
//  Created by Marcelo Hammes on 24/09/20.
//  Copyright © 2020 Marcelo Hammes. All rights reserved.
//

import Foundation

enum NetworkResponse<T> {
    case success(T)
    case failure(NetworkError)
}
