//
//  ListOfThoughtsVC.swift
//  FeelGood
//
//  Created by John Bogil on 10/6/18.
//  Copyright © 2018 John Bogil. All rights reserved.
//

import UIKit
import Anchors
import RxCocoa
import RxSwift

class ListOfThoughtsVC: UIViewController {
    
    // MARK: - PROPERTIES
    let disposeBag = DisposeBag()
    let viewModel = ListOfThoughtsVM()
    
    // MARK: - VIEWS
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(ThoughtCell.self, forCellReuseIdentifier: "ThoughtCell")
        return tableView
    }()
    
    lazy var addThoughtButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "Add", style: .plain, target: nil, action: nil)
        return button
    }()
    
    // MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = addThoughtButton
        self.view.backgroundColor = .white
        self.title = "List of thoughts"
        self.view.addSubviews([tableView])
        activate(tableView.anchor.edges)
        self.setupBindings()
    }
    
    // MARK: - BINDINGS
    func setupBindings() {
        let items = viewModel.items
        // Bind the items to the tableview
        items
            .bind(to: tableView.rx.items(cellIdentifier: "ThoughtCell", cellType: ThoughtCell.self)) { (row, element, cell) in
                cell.thoughtLabel.text = element.text
            }
            .disposed(by: disposeBag)

        addThoughtButton.rx.tap
            .subscribe(onNext: {
                self.presentAlert()
            })
            .disposed(by: disposeBag)
    }
    
    func presentAlert() {

        //1. Create the alert controller.
        let alert = UIAlertController(title: "Add thought", message: nil, preferredStyle: .alert)

        //2. Add the text field. You can configure it however you need.
        alert.addTextField()

        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert!.textFields![0] // Force unwrapping because we know it exists.
            guard let text = textField.text else { return }
            let newThought = Thought(withText: text)
            self.viewModel.newItem.accept(newThought)
        }))

        // 4. Present the alert.
        self.present(alert, animated: true, completion: {  })
    }
}

