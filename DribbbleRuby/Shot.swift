//
//  Models.swift
//  DribbbleRuby
//
//  Created by Valerii Korobov on 03.06.17.
//  Copyright © 2017 Valerii Korobov. All rights reserved.
//

import Foundation
import ObjectMapper

struct Shot: Mappable {
    
    var id: Int?
    var title: String?
    var description: String?
    var animated: Bool?
    var images: Image?
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        id                  <- map["id"]
        title               <- map["title"]
        description         <- map["description"]
        animated            <- map["animated"]
        images              <- map["images"]
    }
}

