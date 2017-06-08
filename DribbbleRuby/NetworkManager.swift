//
//  NetworkManager.swift
//  DribbbleRuby
//
//  Created by Valerii Korobov on 03.06.17.
//  Copyright © 2017 Valerii Korobov. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import AlamofireImage

struct API {
    
    static let clientToken = "bc5278980248931e5c8ffeae64d0ef01b526c751652f0c3d57f9e0de2f22f98c"
    static let clientId = "3891da8804d14b2d0c7d2c239428e80d0df2ffe4107d127c336620c99798f67a"
    static let clientSecret = "b305b195cabe1af72a00b7dbd4b9d1d1cd54628b305c04d0e5af87e1284a3f64"
    static let domenURL = "https://api.dribbble.com/"
    static let apiVersion = "v1/"
    static let baseURL = domenURL + apiVersion
    static let shots = baseURL + "shots"
}

final class NetworkManager {
    
    static let sharedInstance = NetworkManager()
    typealias ShotsListHandler = ([Shot]?, NSError?) -> Void
    
    let photoCache = AutoPurgingImageCache(
        memoryCapacity: 100 * 1024 * 1024,
        preferredMemoryUsageAfterPurge: 60 * 1024 * 1024
    )
    
    func loadShots(page: Int, completion: @escaping ShotsListHandler) {
        let parameters: Parameters = ["per_page" : "50",
                                      "sort" : "recent",
                                      "page" : "\(page)"]
        
        let headers: HTTPHeaders = ["Authorization": "Bearer \(API.clientToken)",
            "Accept": "application/json"]
        
        let request = Alamofire.request(URL(string: API.shots)!,
                                        method: .get,
                                        parameters: parameters,
                                        encoding: URLEncoding.default,
                                        headers: headers)
        
        request.responseJSON { (shotsResponse) in
            
            switch shotsResponse.result {
            case .success(let shotArray as [[String : Any]]):
                let mapArray = Mapper<Shot>().mapArray(JSONArray: shotArray)
                
                let filteredShotsArray = mapArray.filter({ (shot) -> Bool in
                    return shot.animated == false
                })
                
                completion(filteredShotsArray, nil)
            case .failure(let error):
                completion(nil, error as NSError)
                
            default: break
            }
        }
    }
}

