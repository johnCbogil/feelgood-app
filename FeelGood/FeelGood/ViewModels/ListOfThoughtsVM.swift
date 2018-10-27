//
//  ListOfThoughtsVM.swift
//  FeelGood
//
//  Created by John Bogil on 10/6/18.
//  Copyright © 2018 John Bogil. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxSwiftExt
import RxOptional
import DefaultsKit

class ListOfThoughtsVM {
    let disposeBag = DisposeBag()

    // MARK: - INPUTS

    // MARK: - OUTPUTS
    let thoughts = BehaviorRelay<[Thought]>(value: [])
    let newThought = PublishRelay<Thought?>()

    init() {
        setupBindings()
        print("Fetching thoughts")
        guard let listOfThoughts = defaults.get(for: thoughtsKey) else { return }
        self.thoughts.accept(listOfThoughts)
        setupNotificationObservers()
    }

    func setupNotificationObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(saveThoughts),
                                               name: NSNotification.Name(rawValue: "saveThoughts"), object: nil)
    }

    @objc func saveThoughts() {
        print(self.thoughts.value)
        defaults.set(self.thoughts.value, for: thoughtsKey)
    }

    func setupBindings() {
        newThought
            .filterNil()
            .subscribe(onNext: { item in
                var currentItems = self.thoughts.value
                currentItems.append(item)
                self.thoughts.accept(currentItems)
            })
            .disposed(by: disposeBag)

        thoughts
            .filterEmpty()
            .subscribe(onNext: { _ in
                print("Saving thoughts")
                self.saveThoughts()
            })
            .disposed(by: disposeBag)
    }
}
