//
//  BaseViewController.swift
//  GithubRepoList
//
//  Created by Marcelo Hammes on 23/09/20.
//  Copyright © 2020 Marcelo Hammes. All rights reserved.
//

import UIKit

class BaseViewController<CustomView: BaseView>: UIViewController {
    
    var customView: CustomView {
        return view as! CustomView
    }
    
    override func loadView() {
        view = CustomView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        customView.setupViews()
//        customView.setupConstraints()
    }
}

