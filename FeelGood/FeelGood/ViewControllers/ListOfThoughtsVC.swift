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
        tableView.delegate = self
        tableView.tableFooterView = UIView()
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
        let items = viewModel.thoughts
        // Bind the items to the tableview
        items
            .bind(to: tableView.rx.items(cellIdentifier: "ThoughtCell",
                                         cellType: ThoughtCell.self)) { (_, element, cell) in
                                            cell.configure(thought: element)
            }
            .disposed(by: disposeBag)

        addThoughtButton.rx.tap
            .subscribe(onNext: {
                self.presentAlert()
            })
            .disposed(by: disposeBag)

        tableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                self?.tableView.deselectRow(at: indexPath, animated: true)
                self?.navigationController?.pushViewController(ThoughtDetailVC(), animated: true)
            })
            .disposed(by: disposeBag)
    }

    private func presentAlert() {

        //1. Create the alert controller.
        let alert = UIAlertController(title: "Add thought", message: nil, preferredStyle: .alert)

        //2. Add the text field. You can configure it however you need.
        alert.addTextField()

        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert!.textFields![0] // Force unwrapping because we know it exists.
            guard let text = textField.text else { return }
            if text.isNotEmpty {
                let newThought = Thought(withText: text)
                self.viewModel.newThought.accept(newThought)
            }
        }))

        // 4. Present the alert.
        self.present(alert, animated: true, completion: {  })
    }
}

extension ListOfThoughtsVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
