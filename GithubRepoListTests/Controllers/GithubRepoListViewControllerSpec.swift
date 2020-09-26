//
//  GithubRepoListViewControllerSpec.swift
//  GithubRepoListTests
//
//  Created by Marcelo Hammes on 26/09/20.
//  Copyright © 2020 Marcelo Hammes. All rights reserved.
//

@testable import GithubRepoList
import Nimble
import Quick
import Foundation

class GithubRepoListViewControllerSpec: QuickSpec {
    override func spec() {
        var viewController: GithubRepoListViewController!
        var view: GithubRepoListViewMock!
        
        beforeEach {
            viewController = GithubRepoListViewController()
            view = GithubRepoListViewMock()
            viewController.view = view
            
            setGithubAPIMockService(GithubService.searchRepositories(language: "Swift", page: 1, perPage: 2))
        }
        
        when("viewController is loaded") {
            then ("numberOfCallsSetupViews should be 1") {
                expect(view.numberOfCallsSetupViews).to(equal(1))
            }
        }
        
        when("viewController is loaded") {
            beforeEach {
                viewController.view.layoutSubviews()
            }
            then ("numberOfCallsSetupConstraints should be 1") {
                expect(view.numberOfCallsSetupConstraints).to(equal(1))
            }
        }
        
        when("loadData is called with success") {
            beforeEach {
                viewController.loadData()
            }
            
            then("repositories should be populated") {
                expect(viewController.repositories).toEventuallyNot(beEmpty())
            }
        }
        
        when("loadData is called with failure") {
            beforeEach {
                setGithubAPIMockServiceWith500()
                viewController.loadData()
            }
            
            then("repositories should be empty") {
                expect(viewController.repositories).toEventually(beEmpty())
            }
        }
    }
}
