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
    }
    
    override func tearDown() {
        imagesDict = nil
        shotsDict = nil
        super.tearDown()
    }
    
    func testThatNoMoreThanFiftyShotsAdded() {
        var dictArray = [[String : Any]]()
        // 1. Given
        for _ in 0..<60 {
            dictArray.append(shotsDict)
        }
        
        let mapArray = Mapper<Shot>().mapArray(JSONArray: dictArray)
        
        // 2. Then
        ShotsViewModel.shots = mapArray
        
        // 3. Then:
        XCTAssertFalse(ShotsViewModel.shotsArray.count > 50)
        XCTAssertFalse(ShotsViewModel.shotsArray.count < 50)
        XCTAssertTrue(ShotsViewModel.shotsArray.count == 50)
    }
    
    func testPerformanceExample() {
        self.measure {
        }
    }
}
