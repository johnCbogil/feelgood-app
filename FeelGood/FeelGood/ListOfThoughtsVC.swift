//
//  ListOfThoughtsVC.swift
//  FeelGood
//
//  Created by John Bogil on 10/6/18.
//  Copyright © 2018 John Bogil. All rights reserved.
//

import UIKit

class ListOfThoughtsVC: UIViewController {
    
    // MARK: - VIEWS
    lazy var tableView: UITableView = {
       let tableView = UITableView()
        return tableView
    }()
    
    // MARK: - LIFECYCLE
    // MARK: - PROPERTIES
    // MARK: - BINDINGS

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.title = "List of thoughts"
    }
}

