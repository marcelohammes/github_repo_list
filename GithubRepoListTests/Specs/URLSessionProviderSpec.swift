//
//  URLSessionProviderSpec.swift
//  GithubRepoListTests
//
//  Created by Marcelo Hammes on 24/09/20.
//  Copyright © 2020 Marcelo Hammes. All rights reserved.
//

@testable import GithubRepoList
import Nimble
import Quick

final class URLSessionProviderSpec: QuickSpec {
    override func spec() {
        var dataTask: URLSessionDataTaskMock!
        var provider: URLSessionProvider!
        var session: URLSessionMock!
        
        beforeEach {
            dataTask = URLSessionDataTaskMock()
            session = URLSessionMock(dataTask: dataTask)
            provider = URLSessionProvider(session: session)
        }
        
        when("Request is called") {
            beforeEach {
                provider.request(type: ModelMock.self, service: ServiceMock.jsonResponseWith200, completion: { _ in })
            }
            
            then("Session should call dataTask") {
                expect(session.dataTaskCalled).to(beTrue())
            }
        }
    }
}
