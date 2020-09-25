//
//  ServiceMock.swift
//  GithubRepoListTests
//
//  Created by Marcelo Hammes on 24/09/20.
//  Copyright © 2020 Marcelo Hammes. All rights reserved.
//

@testable import GithubRepoList
import Foundation
import Nimble
import Quick

enum ServiceMock: ServiceProtocol {
    
    case jsonResponseWith200
    case jsonResponseWithURLParametersWith200
    case errorWith400
    case errorWith500
    
    var baseURL: URL { URL(string: "https://google.com/")! }
    
    var path: String { "api" }
    
    var method: HTTPMethod {
        switch self {
        case .jsonResponseWith200:
            return .post
        default:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .jsonResponseWith200:
            return .requestPlain
        default:
            let parameters = ["test": "test"]
            return .requestParameters(parameters)
        }
    }
    
    var headers: Headers? { return [:] }
    
    var parametersEncoding: ParametersEncoding {
        switch self {
        case .jsonResponseWith200:
            return .json
        default:
            return .url
        }
    }
}
