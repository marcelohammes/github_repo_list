//
//  Repository.swift
//  GithubRepoList
//
//  Created by Marcelo Hammes on 24/09/20.
//  Copyright © 2020 Marcelo Hammes. All rights reserved.
//

import Foundation

struct GithubResponse: Codable {
    let items: [Repository]
}

struct Repository: Codable {
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

struct Owner: Codable {
    let id: Int
    let login: String
    let avatarURL: URL
    
    enum CodingKeys: String, CodingKey {
        case id
        case login
        case avatarURL = "avatar_url"
    }
}
