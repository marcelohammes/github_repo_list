//
//  GithubRepoListViewMock.swift
//  GithubRepoListTests
//
//  Created by Marcelo Hammes on 26/09/20.
//  Copyright © 2020 Marcelo Hammes. All rights reserved.
//

import Foundation
@testable import GithubRepoList

class GithubRepoListViewMock: GithubRepoListView {
    var numberOfCallsSetupViews = 0
    var numberOfCallsSetupConstraints = 0
    
    override func setupViews() {
        numberOfCallsSetupViews += 1
    }
    
    override func setupConstraints() {
        numberOfCallsSetupConstraints += 1
    }
}
