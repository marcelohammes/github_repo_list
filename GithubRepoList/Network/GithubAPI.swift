//
//  GithubAPI.swift
//  GithubRepoList
//
//  Created by Marcelo Hammes on 24/09/20.
//  Copyright © 2020 Marcelo Hammes. All rights reserved.
//

import Combine
import Foundation

struct GithubAPI {
    static let provider = ServiceProvider()
}

extension GithubAPI {
        
    static func starestSwiftRepos(page: Int = 1, perPage: Int = 10) -> AnyPublisher<GithubResponse, Error> {
        let service = GithubService.searchRepositories(language: "swift", page: page, perPage: perPage)
        return run(service)
        
    }

    static func run<T>(_ service: Service) -> AnyPublisher<T, Error> where T: Decodable {
        return provider.run(service)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
