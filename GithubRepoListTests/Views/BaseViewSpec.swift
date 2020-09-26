//
//  BaseViewSpec.swift
//  GithubRepoListTests
//
//  Created by Marcelo Hammes on 26/09/20.
//  Copyright © 2020 Marcelo Hammes. All rights reserved.
//

@testable import GithubRepoList
import Foundation
import Quick
import Nimble

final class BaseViewSpec: QuickSpec {
    override func spec() {
        var baseView: BaseView!
        
        beforeEach {
            baseView = BaseView()
        }
        
        when("BaseView is instanciated") {
            then("baseView should not be nil") {
                expect(baseView).toNot(beNil())
            }
        }
        
        when("BaseView is instanciated with a NSCoder") {
            then("baseView should throw assertion") {
                expect { BaseView(coder: NSCoder()) }.to(throwAssertion())
            }
        }
        
        when("BaseView.setupViews() is called") {
            then("BaseView.setupViews() should throw assertion") {
                expect { baseView.setupViews() }.to(throwAssertion())
            }
        }
        
        when("BaseView.setupConstraints() is called") {
            then("BaseView.setupConstraints() should throw assertion") {
                expect { baseView.setupConstraints() }.to(throwAssertion())
            }
        }
    }
}

