//
//  BaseViewControllerTests.swift
//  GithubRepoListTests
//
//  Created by Marcelo Hammes on 23/09/20.
//  Copyright © 2020 Marcelo Hammes. All rights reserved.
//

@testable import GithubRepoList
import Quick
import Nimble
import XCTest

class BaseViewControllerTests: XCTestCase {

    var baseViewController: BaseViewController<BaseView>!
    
    override func setUp() {
        baseViewController = BaseViewController()
    }

    override func tearDown() {
        
    }

    func testCustomView() {
        expect(self.baseViewController.customView).to(beAKindOf(BaseView.self))
    }

}
