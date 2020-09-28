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
import Foundation

final class URLSessionProviderSpec: QuickSpec {
    override func spec() {
        var dataTask: URLSessionDataTaskMock!
        var provider: URLSessionProvider!
        var session: URLSessionMock!
        var response: NetworkResponse<ModelMock>?
        
        beforeEach {
            dataTask = URLSessionDataTaskMock()
            session = URLSessionMock(dataTask: dataTask)
            provider = URLSessionProvider(session: session)
            response = nil
        }
        
        when("Request is called") {
            beforeEach {
                provider.request(type: ModelMock.self, service: ServiceMock.jsonResponseWith200, completion: { _ in })
            }
            
            then("Session should call dataTask") {
                expect(session.dataTaskCalled).to(beTrue())
            }
            
            then("Request should set proper url") {
                let request = URLRequest(service: ServiceMock.jsonResponseWith200)
                expect(request.url).to(equal(session.lastURL))
            }
            
            then("URLSessionTask should resume") {
                expect(dataTask.isResumeCalled).to(beTrue())
            }
        }
        
        when("Request is called with json response, status code 200") {
            beforeEach {
                session.service = ServiceMock.jsonResponseWith200
                provider.request(type: ModelMock.self, service: ServiceMock.jsonResponseWith200, completion: { networkResponse in response = networkResponse })
            }
            
            then("Should complete with success response") {
                expect(response).to(beSuccessful())
            }
            
            then("Should return given model") {
                let expectedModel = ModelMock(test: "test")
                expect(response).to(beSuccessful(with: expectedModel))
            }
        }
        
        when("Request is called with 400 error response (bad request)") {
            beforeEach {
                session.service = ServiceMock.errorWith400
                provider.request(type: ModelMock.self, service: ServiceMock.errorWith400) { networkResponse in response = networkResponse }
            }
            
            then("Request completed with failure") {
                expect(response).to(beFailed())
            }
        }
        
        when("Request is called with 500 error response (server exception)") {
            beforeEach {
                session.service = ServiceMock.errorWith500
                provider.request(type: ModelMock.self, service: ServiceMock.errorWith500) { networkResponse in response = networkResponse }
            }
            
            then("Request completed with failure") {
                expect(response).to(beFailed())
            }
        }
        
        when("Request is called with json response, URL parameters, status code 200") {
            beforeEach {
                session.service = ServiceMock.jsonResponseWithURLParametersWith200
                provider.request(type: ModelMock.self, service: ServiceMock.jsonResponseWithURLParametersWith200, completion: { networkResponse in response = networkResponse })
            }
            
            then("HttpBody shoud be empty") {
                expect(session.isHttpBodyEmpty).to(beTrue())
            }
            
            then("URL should contains parameters") {
                let urlComponents = URLComponents(service: ServiceMock.jsonResponseWithURLParametersWith200)
                expect(session.lastURL).to(equal(urlComponents.url))
                expect(session.lastURL?.absoluteString).to(contain("test"))
            }
            
            then("Should complete with success response") {
                expect(response).to(beSuccessful())
            }
            
            then("Should return model") {
                expect(response).to(beSuccessful(with: ModelMock(test: "test")))
            }
        }
    }
}
