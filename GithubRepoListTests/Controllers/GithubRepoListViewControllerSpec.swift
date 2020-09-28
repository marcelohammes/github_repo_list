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
import UIKit

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
        
        when("prefetchNextPage can be called and its called") {
            var page = 0
            beforeEach {
                page = viewController.currentPage
                viewController.hasMoreResults = true
                viewController.reposPerPage = 0
                viewController.prefetchNextPage()
            }
            
            then("viewController.isFetching should be true") {
                expect(viewController.currentPage).to(beGreaterThan(page))
            }
        }
        
//        when("the API requests is blocked") {
//            beforeEach {
//                viewController.blockFetchForOneMinuteFrom = Date()
//                viewController.prefetchNextPage()
//            }
//            
//            then("") {
//                expect(viewcontroller.)
//            }
//        }
        
//        when("loadData is called with failure") {
//            beforeEach {
//                setGithubAPIMockServiceWith500()
//                viewController.loadData()
//            }
//            
//            then("repositories should be empty") {
//                expect(viewController.repositories).toEventually(beEmpty())
//            }
//        }
        
//        when("loadData is called with requestLimit failure") {
//            beforeEach {
//                setGithubAPIMockServiceWith403()
//                viewController.loadData()
//            }
//            
//            then("An UIAlertViewController should be presented with the string: GithubAPILimitError") {
//                expect(viewController.presentedViewController).to(beAKindOf(UIAlertController.self))
//                
//                guard let alertVC = viewController.presentedViewController as! UIAlertController else { return }
//                
//                expect(alertVC.message).to(equal(NSLocalizedString("UIAlertController", comment: "")))
//            }
//        }
    }
}
