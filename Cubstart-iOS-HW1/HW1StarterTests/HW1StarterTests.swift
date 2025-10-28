//
//  HW1StarterTests.swift
//  HW1StarterTests
//
//  Created by Justin Wong on 9/8/24.
//

import XCTest
@testable import HW1Starter

final class HW1StarterTests: XCTestCase {
    
    private let hw1Questions = HW1Questions()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetFileNames1() {
        let fileNames = [
            "Moonlit_Wonder_42.pdf",
            "Recipe_Cookies_09.docx",
            "Project_X_Specs.xlsx",
            "Holiday_Pictures_2024.zip",
            "Meeting_Notes_Sept.txt",
            "Q3pXs.jpeg",
            "tH2dV.png",
            "Financial_Report_Q2.pptx",
            "Code_Snippets_v3.5.py",
            "Book_Review_The_Art.txt",
            "Music_Playlist_Favorites.m3u",
            "sW3tQ.applescript"
        ]
        
        let ans = ["Q3pXs.jpeg",
                   "tH2dV.png",
                   "sW3tQ.applescript"]
        XCTAssertEqual(hw1Questions.getFileNames(for: fileNames, withCount: 5), ans, "File names do not match reference")
    }
    
    func testGetFileNames2() {
        let fileNames = [
            "Moonlit_Wonder_42.pdf",
            "Recipe_Cookies_09.docx",
            "z.bye",
            "Project_X_Specs.xlsx",
            "Holiday_Pictures_2024.zip",
            "Meeting_Notes_Sept.txt",
            "a.jpeg",
            "tH2dV.png",
            "Financial_Report_Q2.pptx",
            "b.hi",
            "Code_Snippets_v3.5.py",
            "Book_Review_The_Art.txt",
            ".oski",
            "Music_Playlist_Favorites.m3u",
            "c.applescript"
        ]
        
        let ans = ["z.bye",
                   "a.jpeg",
                   "b.hi",
                   "c.applescript"]
        XCTAssertEqual(hw1Questions.getFileNames(for: fileNames, withCount: 1), ans, "File names do not match reference")
    }
    
    func testCanEscape1() {
        let instructions: [[HW1Questions.Direction]] = [
            [.up, .right, .right],                  // Instruction 1: IGNORED because contains '.up'
            [.right, .right, .right, .left],        // Instruction 2: INVALID because ended up on index 3
            [.right, .left, .right, .right, .right] // Instruction 3: VALID becuase ended up at index 4 which is where the hole is
        ]
        let canEscape = hw1Questions.canEscape(withDirections: instructions, startingIndex: 1, escapeIndex: 4)
        XCTAssertTrue(canEscape, "Gotten canEscape: \(canEscape). Expected: True")
    }
    
    func testCanEscape2() {
        let instructions: [[HW1Questions.Direction]] = [
            [.down, .right, .left, .up, .left, .right],
            [.right, .left, .left, .left, .right, .right, .right, .left, .right],
            [.right, .right, .right, .left, .right, .right, .right, .right],
            [.right, .right, .right, .left, .right, .right],
            [.left, .right, .right, .left, .right, .right, .right],
            [.left, .left, .left, .left, .right, .right, .right, .right, .right, .right, .right]
        ]
        
        let canEscape = hw1Questions.canEscape(withDirections: instructions, startingIndex: 3, escapeIndex: 7)
        XCTAssertTrue(canEscape, "Gotten canEscape: \(canEscape). Expected: True")
    }
    
    func testCanEscape3() {
        let instructions: [[HW1Questions.Direction]] = [
            [.right, .left, .right, .left, .left],
            [.right],
            [.left],
            [.right, .right, .left, .left, .left, .left]
        ]
        
        let canEscape = hw1Questions.canEscape(withDirections: instructions, startingIndex: 0, escapeIndex: 0)
        XCTAssertFalse(canEscape, "Gotten canEscape: \(canEscape). Expected: False")
    }
    
    func testCanEscape4() {
        let instructions: [[HW1Questions.Direction]] = [
            [.up],
            [.down],
            []
        ]
        
        let canEscape = hw1Questions.canEscape(withDirections: instructions, startingIndex: 0, escapeIndex: 0)
        XCTAssertTrue(canEscape, "Gotten canEscape: \(canEscape). Expected: True")
    }
    
    func testCanEscape5() {
        let instructions: [[HW1Questions.Direction]] = [
            [.right, .right, .right, .up],
            [.right, .right, .right, .right, .left, .down],
        ]
        
        let canEscape = hw1Questions.canEscape(withDirections: instructions, startingIndex: 2, escapeIndex: 5)
        XCTAssertFalse(canEscape, "Gotten canEscape: \(canEscape). Expected: False")
    }
    
    
    // MARK: - Testing Helper Functions
    
    private func assertTreasureCoordsWithRef(userCoords: [(Int, Int)], refCoords: [(Int, Int)]) {
        XCTAssertTrue(refCoords.count == userCoords.count, "Treasure coordinates count does not match the reference coordinates count.")

        for i in 0..<userCoords.count {
            let coord = userCoords[i]
            let ansCoord = refCoords[i]
            XCTAssertTrue(coord.0 == ansCoord.0, "Treasure and reference coord x values do not match")
            XCTAssertTrue(coord.1 == ansCoord.1, "Treasure and reference coord y values do not match")
        }
    }
}

