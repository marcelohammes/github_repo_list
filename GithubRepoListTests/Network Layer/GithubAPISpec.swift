//
//  GithubAPISpecs.swift
//  GithubRepoListTests
//
//  Created by Marcelo Hammes on 25/09/20.
//  Copyright © 2020 Marcelo Hammes. All rights reserved.
//

@testable import GithubRepoList
import Nimble
import Quick
import Foundation

final class GithubAPISpec: QuickSpec {
    override func spec() {
        var dataTask: URLSessionDataTaskMock!
        var session: GithubSessionMock!
        var provider: URLSessionProvider!
        
        var response: NetworkResponse<GithubResponse>?
        
        beforeEach {
            dataTask = URLSessionDataTaskMock()
            session = GithubSessionMock(dataTask: dataTask)
            provider = URLSessionProvider(session: session)
            GithubAPI.provider = provider
            response = nil
        }
        
        when("starestSwiftRepos is Called") {
            beforeEach {
                session.service = GithubService.searchRepositories(language: "Swift", page: 1, perPage: 10)
                GithubAPI.starestSwiftRepos(perPage: 2) { (networkResponse) in
                    response = networkResponse
                }
            }
            
            then("The response should parsed correctly") {
                let expectedResponse = GithubResponse(items: [
                                                        Repository(id: 21700699, name: "awesome-ios", stars: 35701, owner: GithubRepoList.Owner(id: 484656, login: "vsouza", avatarURL: URL(string: "https://avatars2.githubusercontent.com/u/484656?v=4")!)),
                                                        Repository(id: 22458259, name: "Alamofire", stars: 34387, owner: GithubRepoList.Owner(id: 7774181, login: "Alamofire", avatarURL: URL(string: "https://avatars3.githubusercontent.com/u/7774181?v=4")!))
                ])
                expect(response).to(beSuccessful(with: expectedResponse))
            }
            
        }
        
    }
}

