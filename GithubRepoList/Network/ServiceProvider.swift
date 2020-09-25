//
//  ServiceProvider.swift
//  GithubRepoList
//
//  Created by Marcelo Hammes on 24/09/20.
//  Copyright © 2020 Marcelo Hammes. All rights reserved.
//

import Combine
import Foundation

struct ServiceProvider {
    let session = URLSession.shared
    
    func run<T>(_ service: Service, _ decoder: JSONDecoder = JSONDecoder()) -> AnyPublisher<T, Error> where T: Decodable {
        return session
            .dataTaskPublisher(for: service.urlRequest)
            .map(\.data)
            .decode(type: T.self, decoder: decoder)
            .eraseToAnyPublisher()
    }
}
