//
//  BaseViewController.swift
//  GithubRepoList
//
//  Created by Marcelo Hammes on 23/09/20.
//  Copyright © 2020 Marcelo Hammes. All rights reserved.
//

import UIKit

class BaseViewController<View: UIView>: UIViewController {
    
    var customView: View {
        return view as! View
    }
    
    override func loadView() {
        view = View()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GithubAPI.starestSwiftRepos(page: 1, perPage: 10) { (response) in
            switch response {
            case .success(let data):
                print("data = \(data)")
            case .failure(let error):
                print("error = \(error)")
            }
        }
    }
}

