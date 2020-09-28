//
//  GithubRepoListSnapshotTest.swift
//  GithubRepoListTests
//
//  Created by Marcelo Hammes on 27/09/20.
//  Copyright © 2020 Marcelo Hammes. All rights reserved.
//

@testable import GithubRepoList
import FBSnapshotTestCase

class GithubRepoListSnapshotTest: FBSnapshotTestCase {
    override func setUp() {
        super.setUp()
        recordMode = false
    }
    
    func testSnapshotGithubRepoListCollectionViewCell() {
        let view = GithubRepoListCollectionViewCell(frame: CGRect(x: 0, y: 0, width: 320, height: 100))
        let repository = Repository(id: 21700699, name: "awesome-ios", stars: 35701, owner: GithubRepoList.Owner(id: 484656, login: "vsouza", avatarURL: URL(string: "https://avatars2.githubusercontent.com/u/484656?v=4")!))
        view.setData(repository: repository)
        FBSnapshotVerifyView(view)
        FBSnapshotVerifyLayer(view.layer)
    }
}
