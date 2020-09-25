//
//  Task.swift
//  GithubRepoList
//
//  Created by Marcelo Hammes on 24/09/20.
//  Copyright © 2020 Marcelo Hammes. All rights reserved.
//

import Foundation

typealias Parameters = [String: Any]

enum Task {
    case requestPlain
    case requestParameters(Parameters)
}
