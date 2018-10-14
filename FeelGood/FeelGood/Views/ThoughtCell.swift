//
//  ThoughtCell.swift
//  FeelGood
//
//  Created by John Bogil on 10/6/18.
//  Copyright © 2018 John Bogil. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import Anchors

class ThoughtCell: UITableViewCell {

    // MARK: - Properties
    let disposeBag = DisposeBag()
    var thought: Thought?

    // MARK: - Views
    lazy var thoughtLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25, weight: .regular)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()

    lazy var countLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25, weight: .regular)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()

    lazy var gestureRecognizer: UISwipeGestureRecognizer = {
        let gesture = UISwipeGestureRecognizer()
        gesture.direction = .right
        return gesture
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.addSubviews([thoughtLabel, countLabel])
        self.addGestureRecognizer(gestureRecognizer)
        activate(thoughtLabel.anchor.leading.constant(20),
                 countLabel.anchor.trailing.constant(-20))
        setupBindings()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(thought: Thought) {
        self.thought = thought
        self.textLabel?.text = thought.text
    }

    private func setupBindings() {

        gestureRecognizer.rx.event.asDriver()
            .drive(onNext: { _ in
                self.thought?.thoughtCount += 1
            })
            .disposed(by: disposeBag)
    }
}
