//
//  ShotsViewModelTest.swift
//  DribbbleRuby
//
//  Created by Valerii Korobov on 06.06.17.
//  Copyright © 2017 Valerii Korobov. All rights reserved.
//


import XCTest
import ObjectMapper
@testable import DribbbleRuby

class ShotsViewModelTest: XCTestCase {
    var imagesDict: [String : Any]!
    var shotsDict: [String : Any]!
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        imagesDict = nil
        shotsDict = nil
        super.tearDown()
    }
    
    func testThatNoMoreThanFiftyShotsAdded() {
        
        // 1. Given
        imagesDict = [
            "hidpi" : "https://cdn.dribbble.com/users/271024/screenshots/3551173/outlander_logo.png",
            "normal" : "https://cdn.dribbble.com/users/271024/screenshots/3551173/outlander_logo_1x.png",
            "teaser" : "https://cdn.dribbble.com/users/271024/screenshots/3551173/outlander_logo_teaser.png"
        ]
        
        shotsDict = [
            "id" : 471756,
            "title" : "Sasquatch",
            "description" : "Quiconal something.",
            "animated" : "false",
            "images" : imagesDict
            ] as [String : Any]
        
        let mapArray = Mapper<Shot>().mapArray(JSONArray: [shotsDict])
        
        // 2. When:
        for _ in 0...60 {
            ShotsViewModel.shots.append(contentsOf: mapArray)
        }
        
        // 3. Then:
        XCTAssertTrue(ShotsViewModel.shotsArray.count <= 50, "You have more than 50 shots in shotsArray")
    }
    
    func testPerformanceExample() {
        self.measure {
        }
    }
}
