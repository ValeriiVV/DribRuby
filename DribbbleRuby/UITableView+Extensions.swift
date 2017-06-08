//
//  UITableView+Extensions.swift
//  DribbbleRuby
//
//  Created by Valerii Korobov on 03.06.17.
//  Copyright © 2017 Valerii Korobov. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    func registerReusable<T: Reusable>(reusableClass: T.Type, nib: UINib? = nil) {
        self.register(nib ?? UINib(nibName: T.reuseIdentifier, bundle: nil) ,
                      forCellReuseIdentifier: T.reuseIdentifier)
    }
}

extension UITableViewCell: Reusable {}

