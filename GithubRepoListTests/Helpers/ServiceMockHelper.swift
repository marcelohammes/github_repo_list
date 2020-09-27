//
//  ServiceMockHelper.swift
//  GithubRepoListTests
//
//  Created by Marcelo Hammes on 25/09/20.
//  Copyright © 2020 Marcelo Hammes. All rights reserved.
//

@testable import GithubRepoList
import Foundation

func setGithubAPIMockService(_ service: GithubService) {
    let dataTask = URLSessionDataTaskMock()
    let session = GithubSessionMock(dataTask: dataTask)
    let provider = URLSessionProvider(session: session)
    
    GithubAPI.provider = provider
    session.service = service
}

func setGithubAPIMockServiceWith500() {
    let dataTask = URLSessionDataTaskMock()
    let session = URLSessionMock(dataTask: dataTask)
    let provider = URLSessionProvider(session: session)
    
    GithubAPI.provider = provider
    session.service = ServiceMock.errorWith500
}
