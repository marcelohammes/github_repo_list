//
//  GithubRepoListViewController.swift
//  GithubRepoList
//
//  Created by Marcelo Hammes on 25/09/20.
//  Copyright © 2020 Marcelo Hammes. All rights reserved.
//

import UIKit

class GithubRepoListViewController: BaseViewController<GithubRepoListView> {
    
    let reposPerPage = 10
    
    var repositories: [Repository]? {
        didSet {
            DispatchQueue.main.async {
                self.customView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        navigationController?.navigationBar.prefersLargeTitles = true
        
        customView.dataSource = self
        customView.delegate = self
        title = NSLocalizedString("swiftGithubStarestRepos", comment: "")
        
        loadData()
    }
    
    func loadData(page: Int = 1) {
        GithubAPI.starestSwiftRepos(page: page, perPage: reposPerPage) { (networkResponse) in
            switch networkResponse {
            case .success(let response):
                self.repositories = response.items
                
            case .failure(let _):
            // TODO handle and show the error
            break
            }
        }
    }
}

extension GithubRepoListViewController: GithubRepoListViewDataSource {
    func repositoriesCount() -> Int {
        repositories?.count ?? 0
    }

    func repository(for indexPath: IndexPath) -> Repository? {
        return repositories?[indexPath.row]
    }

}


extension GithubRepoListViewController: GithubRepoListViewDelegate {
    func refreshData() {
        loadData()
    }
    
}
