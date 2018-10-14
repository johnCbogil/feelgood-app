//
//  Thought.swift
//  FeelGood
//
//  Created by John Bogil on 10/10/18.
//  Copyright © 2018 John Bogil. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxSwiftExt
import RxOptional

struct Thought: Codable {
    let text: String?
    var thoughtCount = 0

    init(withText text: String?) {
        self.text = text
    }
}
