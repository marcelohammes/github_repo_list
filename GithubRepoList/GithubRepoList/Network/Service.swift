//
//  Service.swift
//  GithubRepoList
//
//  Created by Marcelo Hammes on 24/09/20.
//  Copyright © 2020 Marcelo Hammes. All rights reserved.
//

import Foundation
import Combine

enum ServiceMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

protocol Service {
    var baseURL: String { get }
    var path: String { get }
    var headers: [String: String]? { get }
    var parameters: [String: Any]? { get }
    var method: ServiceMethod { get }
}

extension Service {
    public var urlRequest: URLRequest {
        guard let url = self.url else {
            fatalError("URL could not be built")
        }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        headers?.forEach({ (key, value) in
            request.addValue(value, forHTTPHeaderField: key)
        })
        
        return request
    }
    
    internal var url: URL? {
        let url = baseURL
        var urlComponents = URLComponents(string: url)
        urlComponents?.path = path
        if method == .get {
            if let parameters = parameters as? [String: String] {
                urlComponents?.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
            }
        }
        
        return urlComponents?.url
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
    
    var parameters: [String : Any]? {
        return nil
    }
}

enum GithubService {
    case searchRepositories(language: String, page: Int, perPage: Int)
}

extension GithubService: Service {
    var baseURL: String { return "https://api.github.com" }
    
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
    
    var method: ServiceMethod { .get }
}

struct Agent {
    let session = URLSession.shared
    
    func run<T>(_ service: Service, _ decoder: JSONDecoder = JSONDecoder()) -> AnyPublisher<T, Error> where T: Decodable {
        return session
            .dataTaskPublisher(for: service.urlRequest)
            .map(\.data)
            .decode(type: T.self, decoder: decoder)
            .eraseToAnyPublisher()
    }
}

struct GithubAPI {
    static let agent = Agent()
}

extension GithubAPI {
        
    static func starestSwiftRepos(page: Int = 1, perPage: Int = 10) -> AnyPublisher<GithubResponse, Error> {
        let service = GithubService.searchRepositories(language: "swift", page: page, perPage: perPage)
        return run(service)
        
    }

    static func run<T>(_ service: Service) -> AnyPublisher<T, Error> where T: Decodable {
        return agent.run(service)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
