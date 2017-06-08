//
//  UIImage+Download.swift
//  DribbbleRuby
//
//  Created by Valerii Korobov on 04.06.17.
//  Copyright © 2017 Valerii Korobov. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import AlamofireImage

extension UIImageView {
    func setCashedImage(apiURL: String) {
        if let image = NetworkManager.sharedInstance.photoCache.image(withIdentifier: apiURL) {
            self.image = image
            imageDidSet()
        }
            
        else {
            DataRequest.addAcceptableImageContentTypes(["image/jpeg", "image/jpg", "image/png"])
            
            self.af_setImage(withURL: URL.init(string: apiURL)!,
                             placeholderImage: nil,
                             filter: nil,
                             progress: nil,
                             progressQueue: DispatchQueue.main,
                             imageTransition: .noTransition,
                             runImageTransitionIfCached: false,
                             completion: { (response) in
                                
                                if let image = response.result.value {
                                    NetworkManager.sharedInstance.photoCache.add(image,
                                                                                 withIdentifier: apiURL)
                                    self.image = image
                                    self.imageDidSet()
                                }
            })
        }
    }
    
    func imageDidSet() {
        if (Double((self.image?.size.height)!) > Double((self.image?.size.width)!)) {
            self.contentMode = .scaleAspectFill
        }
            
        else {
            self.contentMode = .scaleAspectFit
        }
    }
}
