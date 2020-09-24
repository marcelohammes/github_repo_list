//
//  BaseViewController.swift
//  GithubRepoList
//
//  Created by Marcelo Hammes on 23/09/20.
//  Copyright © 2020 Marcelo Hammes. All rights reserved.
//

import UIKit
import Combine

class BaseViewController<View: UIView>: UIViewController {
    
    private var disposables = Set<AnyCancellable>()
    
    var customView: View {
        return view as! View
    }
    
    override func loadView() {
        view = View()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let _ = GithubAPI.starestSwiftRepos()
            .print()
            .sink { [weak self] value in
//                guard let self = self else { return }
                switch value {
                case .failure:
                    //                    self.dataSource = []
                    print("fail")
                    break
                case .finished:
                    print("finished")
                    break
                }
            } receiveValue: { [weak self] repository in
//                guard let self = self else { return }
                print(repository)
//                self.dataSource = forecast
            }
            .store(in: &disposables)
    }
}

