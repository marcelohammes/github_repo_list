//
//  GithubService.swift
//  GithubRepoList
//
//  Created by Marcelo Hammes on 24/09/20.
//  Copyright © 2020 Marcelo Hammes. All rights reserved.
//

import Foundation

enum GithubService {
    case searchRepositories(language: String, page: Int, perPage: Int)
}

extension GithubService: ServiceProtocol {
    var baseURL: URL { URL(string: "https://api.github.com")! }
    
    var task: Task {
        return .requestParameters(parameters ?? [:])
    }
    
    var parametersEncoding: ParametersEncoding {
        return .url
    }
    
    var path: String {
        switch self {
        case .searchRepositories:
            return "/search/repositories"
        }
    }

    var headers: [String : String]? {
        ["Content-type": "application/json",
         "accept": "application/vnd.github.v3+json"]
    }

    var parameters: [String : Any]? {
        switch self {
        case .searchRepositories(let language, let page, let perPage):
            return ["q": "language:\(language)",
                    "page": "\(page)",
                    "per_page": "\(perPage)"]
        }
    }

    var method: HTTPMethod { .get }
}
