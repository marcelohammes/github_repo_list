//
//  GithubRepoListViewController.swift
//  GithubRepoList
//
//  Created by Marcelo Hammes on 25/09/20.
//  Copyright © 2020 Marcelo Hammes. All rights reserved.
//

import UIKit

class GithubRepoListViewController: BaseViewController<GithubRepoListView> {
    
    let reposPerPage = 40
    var currentPage = 1
    var isFetching = false
    var hasMoreResults = true
    var blockFetchForOneMinuteFrom: Date?
    
    var repositories: [Repository?] = [] {
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
        
        loadData(page: currentPage)
    }
    
    func loadData(page: Int = 1) {
        guard isFetching == false else { return }
        
        self.currentPage = page
        
        isFetching = true
        GithubAPI.starestSwiftRepos(page: page, perPage: reposPerPage) { (networkResponse) in
            switch networkResponse {
            case .success(let response):
                if page == 1 {
                    self.repositories = response.items
                } else {
                    self.repositories.append(contentsOf: response.items)
                }
                
                self.hasMoreResults = self.repositories.count < response.totalCount
                
                self.isFetching = false
                
            case .failure(let error):
                switch error {
                case .requestLimit:
                    self.blockFetchForOneMinuteFrom = Date()
                    self.showAlert(message: NSLocalizedString("GithubAPILimitError", comment: ""))
                case .noJSONData:
                    self.showAlert(message: NSLocalizedString("GithubAPINoJSON", comment: ""))
                default:
                    self.showAlert(message: NSLocalizedString("GithubAPIGenericError", comment: ""))
                }
                self.isFetching = false
                self.currentPage = page-1
                DispatchQueue.main.async{
                    self.customView.reloadData()
                }
                break
            }
        }
    }
    
    func showAlert(message: String) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: { (action) in
                alertController.dismiss(animated: true)
            }))
            self.present(alertController, animated: true)
        }
    }
}

extension GithubRepoListViewController: GithubRepoListViewDataSource {
    func totalCount() -> Int {
        return self.currentPage * reposPerPage
    }
    
    func prefetchNextPage() {

        if let blockFetchForOneMinuteFrom = blockFetchForOneMinuteFrom, Date().timeIntervalSince(blockFetchForOneMinuteFrom) <= 60 {
            return
        }
        
        if hasMoreResults && (currentPage)*reposPerPage <= repositories.count {
            loadData(page: currentPage+1)
            customView.reloadData()
        }
    }
    
    func repositoriesCount() -> Int {
        repositories.count
    }
    
    func repository(for indexPath: IndexPath) -> Repository? {
        return repositories[indexPath.row]
    }
    
}


extension GithubRepoListViewController: GithubRepoListViewDelegate {    
    func refreshData() {
        if let blockFetchForOneMinuteFrom = blockFetchForOneMinuteFrom, Date().timeIntervalSince(blockFetchForOneMinuteFrom) <= 60 {
            customView.reloadData()
            return
        }
        
        loadData()
    }
    
}
