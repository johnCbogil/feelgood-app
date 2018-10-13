//
//  UIKit+Extensions.swift
//  BlessApp
//
//  Created by John Bogil on 9/23/18.
//  Copyright © 2018 John Bogil. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func addSubviews(_ views: [UIView]) {
        views.forEach(self.addSubview)
    }
}
