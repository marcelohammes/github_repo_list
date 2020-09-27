//
//  Repository.swift
//  GithubRepoList
//
//  Created by Marcelo Hammes on 24/09/20.
//  Copyright © 2020 Marcelo Hammes. All rights reserved.
//

import Foundation

struct GithubResponse: Codable, Equatable {
    let items: [Repository]
    let totalCount: Int
    
    enum CodingKeys: String, CodingKey {
        case items
        case totalCount = "total_count"
    }
}

struct Repository: Codable, Equatable {
    let id: Int
    let name: String
    let stars: Int
    let owner: Owner
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case stars = "stargazers_count"
        case owner
    }
}

struct Owner: Codable, Equatable {
    let id: Int
    let login: String
    let avatarURL: URL
    
    enum CodingKeys: String, CodingKey {
        case id
        case login
        case avatarURL = "avatar_url"
    }
}
