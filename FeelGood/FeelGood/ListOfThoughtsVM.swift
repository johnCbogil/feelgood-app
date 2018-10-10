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

struct ListOfThoughtsVM {
    let disposeBag = DisposeBag()

    // MARK: - INPUTS

    // MARK: - OUTPUTS
    let items = BehaviorRelay<[Thought]>(value: [])
    let newItem = PublishRelay<Thought?>()

    init() {
        setupBindings()
    }

    func setupBindings() {
        newItem
            .filterNil()
            .subscribe(onNext: { item in
                var currentItems = self.items.value
                currentItems.append(item)
                self.items.accept(currentItems)
            })
            .disposed(by: disposeBag)
    }
}


