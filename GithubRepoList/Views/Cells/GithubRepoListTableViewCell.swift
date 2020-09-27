//
//  GithubRepoListCollectionViewCell.swift
//  GithubRepoList
//
//  Created by Marcelo Hammes on 26/09/20.
//  Copyright © 2020 Marcelo Hammes. All rights reserved.
//

import Kingfisher
import UIKit

class GithubRepoListCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "GithubRepoListCollectionViewCell"
    
    private let padding: CGFloat = 8
    private let imageDimension: CGFloat = 50
    
    lazy var repoNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22)
        label.textColor = .label
        return label
    }()
    lazy var startsCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 14)
        label.textColor = UIColor(named: "starsColor")
        return label
    }()
    lazy var repoOwnerNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    lazy var repoOwnerAvatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = imageDimension/2
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Invalid constructor")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
    }
    
    func setupViews() {
        setupShadow()
        
        backgroundColor = .secondarySystemBackground
        
        addSubview(repoNameLabel)
        addSubview(startsCountLabel)
        addSubview(repoOwnerNameLabel)
        addSubview(repoOwnerAvatarImageView)
    }
    
    func setupConstraints() {
        
        let repoOwnerAvatarImageViewConstraints = [
            repoOwnerAvatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            repoOwnerAvatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            repoOwnerAvatarImageView.widthAnchor.constraint(equalToConstant: imageDimension),
            repoOwnerAvatarImageView.heightAnchor.constraint(equalTo: repoOwnerAvatarImageView.widthAnchor),
        ]
        NSLayoutConstraint.activate(repoOwnerAvatarImageViewConstraints)
        
        let repoNameLabelConstraints = [
            repoNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            repoNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: padding),
            repoNameLabel.leadingAnchor.constraint(equalTo: repoOwnerAvatarImageView.trailingAnchor, constant: padding*2),
        ]
        NSLayoutConstraint.activate(repoNameLabelConstraints)
        
        
        let repoOwnerNameLabelConstraints = [
            repoOwnerNameLabel.topAnchor.constraint(equalTo: repoNameLabel.bottomAnchor, constant:  padding),
            repoOwnerNameLabel.trailingAnchor.constraint(equalTo: repoNameLabel.trailingAnchor),
            repoOwnerNameLabel.leadingAnchor.constraint(equalTo: repoNameLabel.leadingAnchor),
        ]
        NSLayoutConstraint.activate(repoOwnerNameLabelConstraints)
        
        let startsCountLabelConstraints = [
            startsCountLabel.topAnchor.constraint(equalTo: repoOwnerNameLabel.bottomAnchor, constant:  padding),
            startsCountLabel.trailingAnchor.constraint(equalTo: repoNameLabel.trailingAnchor),
            startsCountLabel.leadingAnchor.constraint(equalTo: repoNameLabel.leadingAnchor),
            startsCountLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding),
        ]
        NSLayoutConstraint.activate(startsCountLabelConstraints)
    }
    
    func setData(repository: Repository) {
        repoOwnerAvatarImageView.kf.setImage(with: repository.owner.avatarURL)
        repoNameLabel.text = repository.name
        repoOwnerNameLabel.text = "👤 \(repository.owner.login)"
        startsCountLabel.text = "★ \(repository.stars)"
    }
}

extension UIView {
    func setupShadow() {
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 5)
        layer.cornerRadius = 5
        layer.masksToBounds = false
        layer.shadowColor = UIColor.systemFill.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 3)
        layer.shadowOpacity = 1
        layer.shadowPath = shadowPath.cgPath
    }
}

class LoadingCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "LoadingCollectionViewCell"
    
    private let loaderDimension: CGFloat = 50
    
    lazy var loader: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView()
        loader.translatesAutoresizingMaskIntoConstraints = false
        return loader
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Invalid constructor")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
        loader.startAnimating()
    }
    
    func setupViews() {
        setupShadow()
        backgroundColor = .secondarySystemBackground
        addSubview(loader)
    }
    
    func setupConstraints() {
        
        let loaderConstraints = [
            loader.centerXAnchor.constraint(equalTo: centerXAnchor),
            loader.centerYAnchor.constraint(equalTo: centerYAnchor)
        ]
        NSLayoutConstraint.activate(loaderConstraints)
    }
}
