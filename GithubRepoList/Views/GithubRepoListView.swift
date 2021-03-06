//
//  GithubRepoListView.swift
//  GithubRepoList
//
//  Created by Marcelo Hammes on 25/09/20.
//  Copyright © 2020 Marcelo Hammes. All rights reserved.
//

import UIKit

protocol GithubRepoListViewDataSource {
    func repository(for indexPath: IndexPath) -> Repository?
    func repositoriesCount() -> Int
    func totalCount() -> Int
    func prefetchNextPage()
}

protocol GithubRepoListViewDelegate {
    func refreshData()
}

class GithubRepoListView: BaseView {
    let padding: CGFloat = 16
    var didBeginScrollToTop = false
    lazy var githubReposCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.prefetchDataSource = self
        collectionView.backgroundColor = .systemBackground
        collectionView.layer.masksToBounds = false
        collectionView.accessibilityLabel = "Github Repositories List"
        collectionView.accessibilityIdentifier = "Github Repositories List"
        return collectionView
    }()
    
    lazy var refreshControl: UIRefreshControl = {
        let refresher = UIRefreshControl()
        refresher.accessibilityLabel = "Refresh Indicator"
        return refresher
    }()
    
    var dataSource: GithubRepoListViewDataSource?
    var delegate: GithubRepoListViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Invalid constructor")
    }
    
    override func layoutSubviews() {
        setupConstraints()
    }
    
    override func setupViews() {
        
        githubReposCollectionView.alwaysBounceVertical = true
        refreshControl.tintColor = .label
        refreshControl.addTarget(delegate, action: #selector(refresherTriggered), for: .valueChanged)
        githubReposCollectionView.addSubview(refreshControl)
        
        githubReposCollectionView.register(GithubRepoListCollectionViewCell.self, forCellWithReuseIdentifier: GithubRepoListCollectionViewCell.cellIdentifier)
        githubReposCollectionView.register(LoadingCollectionViewCell.self, forCellWithReuseIdentifier: LoadingCollectionViewCell.cellIdentifier)
        
        addSubview(githubReposCollectionView)
    }
    
    override func setupConstraints() {
        
        let githubReposCollectionViewConstraints = [
            githubReposCollectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: padding),
            githubReposCollectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            githubReposCollectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -padding),
            githubReposCollectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: padding)
        ]
        NSLayoutConstraint.activate(githubReposCollectionViewConstraints)
    }
    
    @objc func refresherTriggered() {
        delegate?.refreshData()
    }
    
    func reloadData() {
        self.githubReposCollectionView.reloadData()
        self.refreshControl.endRefreshing()
    }
}


extension GithubRepoListView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let dataSource = dataSource else { return 0 }
        
        return dataSource.totalCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard indexPath.row < dataSource?.repositoriesCount() ?? 0 else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LoadingCollectionViewCell.cellIdentifier, for: indexPath) as? LoadingCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            return cell
        }
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GithubRepoListCollectionViewCell.cellIdentifier, for: indexPath) as? GithubRepoListCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        if let repository = dataSource?.repository(for: indexPath) {
            cell.setData(repository: repository)
        }
        
        return cell
    }
    
}

extension GithubRepoListView: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        func isLoadingCell(for indexPath: IndexPath) -> Bool {
            return indexPath.row >= (dataSource?.repositoriesCount() ?? 0)-2
        }
        
        if indexPaths.contains(where: isLoadingCell) {
            dataSource?.prefetchNextPage()
        }
    }
}

extension GithubRepoListView: UICollectionViewDelegate {
    func scrollViewShouldScrollToTop(_ scrollView: UIScrollView) -> Bool {
        didBeginScrollToTop = true
        return true
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > scrollView.contentSize.height - scrollView.visibleSize.height {
            dataSource?.prefetchNextPage()
        }
        
        guard didBeginScrollToTop, scrollView.contentOffset.y < -25 else { return }

        scrollView.setContentOffset(.zero, animated: true)
    }

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        didBeginScrollToTop = false
    }
}

extension GithubRepoListView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width, height: 100)
    }
}
