//
//  Thought.swift
//  FeelGood
//
//  Created by John Bogil on 10/10/18.
//  Copyright © 2018 John Bogil. All rights reserved.
//

import Foundation

struct Thought: Codable {
    let text: String

    init(withText text: String) {
        self.text = text
    }
}
