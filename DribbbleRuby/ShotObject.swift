//
//  ShotObject.swift
//  DribbbleRuby
//
//  Created by Valerii Korobov on 04.06.17.
//  Copyright © 2017 Valerii Korobov. All rights reserved.
//

import UIKit

class ShotObject: NSObject, NSCoding {

    var title:              String!
    var descriptionString:  String!
    var image:              String!
    
    init(title: String, descriptionString: String, image: String) {
        self.title = title
        self.descriptionString = descriptionString
        self.image = image
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let title = aDecoder.decodeObject(forKey: "title") as! String
        let descriptionString = aDecoder.decodeObject(forKey: "descriptionString") as! String
        let image = aDecoder.decodeObject(forKey: "image") as! String
        self.init(title: title, descriptionString: descriptionString, image: image)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: "title")
        aCoder.encode(descriptionString, forKey: "descriptionString")
        aCoder.encode(image, forKey: "image")
    }
}
