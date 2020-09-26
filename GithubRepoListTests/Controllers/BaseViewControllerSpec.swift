//
//  BaseViewControllerSpec.swift
//  GithubRepoListTests
//
//  Created by Marcelo Hammes on 23/09/20.
//  Copyright © 2020 Marcelo Hammes. All rights reserved.
//

@testable import GithubRepoList
import Quick
import Nimble

final class BaseViewControllerSpec: QuickSpec {
    override func spec() {
        var baseViewController: BaseViewController<BaseView>!
        
        beforeEach {
            baseViewController = BaseViewController()
        }
        
        when("BaseViewController is instanciated") {
            then("CustomView should be kind of a BaseView") {
                expect(baseViewController.customView).to(beAKindOf(BaseView.self))
            }
        }
    }
}
