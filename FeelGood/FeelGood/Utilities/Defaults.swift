//
//  Defaults.swift
//  FeelGood
//
//  Created by John Bogil on 10/10/18.
//  Copyright © 2018 John Bogil. All rights reserved.
//

import Foundation
import DefaultsKit

let defaults = Defaults(userDefaults: UserDefaults.standard)

let thoughtsKey = Key<[Thought]>("thoughtsKey")
