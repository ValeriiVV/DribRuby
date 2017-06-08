//
//  ShotsViewModel.swift
//  DribbbleRuby
//
//  Created by Valerii Korobov on 03.06.17.
//  Copyright © 2017 Valerii Korobov. All rights reserved.
//

import UIKit

class ShotsViewModel {
    static var shotsArray = [ShotObject]()
    
    static var shots = [Shot]() {
        didSet {
            for shot in shots {
                
                let object = ShotObject.init(title: shot.title != nil ? shot.title! : "",
                                             descriptionString: shot.description != nil ? shot.description! : "",
                                             image: (shot.images?.hidpi != nil ? shot.images?.hidpi : shot.images?.normal)!)
                if (shotsArray.count == 50) {
                    break
                }
                
                shotsArray.append(object)
            }
        }
    }
}
