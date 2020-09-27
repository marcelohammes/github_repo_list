//
//  QuickCustomAliases.swift
//  GithubRepoListTests
//
//  Created by Marcelo Hammes on 24/09/20.
//  Copyright © 2020 Marcelo Hammes. All rights reserved.
//

import Quick

func given(_ description: String, closure: @escaping () -> ()) {
    describe(description, closure: closure)
}

func when(_ description: String, closure: @escaping () -> ()) {
    context(description, closure: closure)
}

func then(_ description: String, closure: @escaping () -> ()) {
    it(description, closure: closure)
}

func onlyThen(_ description: String, closure: @escaping () -> ()) {
    fit(description, closure: closure)
}
