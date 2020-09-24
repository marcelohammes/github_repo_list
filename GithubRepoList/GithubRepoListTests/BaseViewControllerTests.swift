//
//  BaseViewControllerTests.swift
//  GithubRepoListTests
//
//  Created by Marcelo Hammes on 23/09/20.
//  Copyright © 2020 Marcelo Hammes. All rights reserved.
//

@testable import GithubRepoList
import Nimble
import XCTest

class BaseViewControllerTests: XCTestCase {

    var baseViewController: BaseViewController<UIView>!
    
    override func setUp() {
        baseViewController = BaseViewController()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCustomView() {
        expect(self.baseViewController.customView).to(beAKindOf(UIView.self))
    }

}
