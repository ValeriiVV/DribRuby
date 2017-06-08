//
//  Image.swift
//  DribbbleRuby
//
//  Created by Valerii Korobov on 04.06.17.
//  Copyright © 2017 Valerii Korobov. All rights reserved.
//

import Foundation
import ObjectMapper

struct Image: Mappable {
    
    var hidpi: String?
    var normal: String?
    var teaser: String?
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        hidpi       <- map["hidpi"]
        normal      <- map["normal"]
        teaser      <- map["teaser"]
    }
}
