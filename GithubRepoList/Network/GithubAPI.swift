//
//  GithubAPI.swift
//  GithubRepoList
//
//  Created by Marcelo Hammes on 24/09/20.
//  Copyright © 2020 Marcelo Hammes. All rights reserved.
//

import Foundation

struct GithubAPI {
    static var provider = URLSessionProvider()
    static var blockAPIForOneMinuteFrom = false
}

extension GithubAPI {
        
    static func starestSwiftRepos(page: Int = 1, perPage: Int = 10, _ completion: @escaping (NetworkResponse<GithubResponse>) -> ()){
        guard blockAPIForOneMinuteFrom == false else {
            completion(.failure(.requestLimit))
            return
        }
        
        let service = GithubService.searchRepositories(language: "swift", page: page, perPage: perPage)
        return run(service, completion)
        
    }

    static func run<T>(_ service: ServiceProtocol, _ completion: @escaping (NetworkResponse<T>) -> ()) where T: Decodable {
        return provider.request(type: T.self, service: service) { response in
            switch response {
            case .failure(let error):
                if error == .requestLimit {
                    blockAPIForOneMinuteFrom = true
                    DispatchQueue.global().asyncAfter(deadline: .now()+60) {
                        blockAPIForOneMinuteFrom = false
                    }
                }
            default:
                break
            }
            
            completion(response)
        }
    }
}
