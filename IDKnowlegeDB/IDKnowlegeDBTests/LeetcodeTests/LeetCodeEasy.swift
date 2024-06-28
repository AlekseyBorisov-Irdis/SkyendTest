//
//  LeetCodeEasy.swift
//  IDKnowlegeDBTests
//
//  Created by Alexey on 28.06.2024.
//

import Foundation
import XCTest
@testable import IDKnowlegeDB

final class LeetCodeEasy: XCTestCase {
  
  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
  func testLongestCommonPrefix() throws {
    let arr1 = ["flower","flow","flight"]
    let arr2 = ["dog","racecar","car"]
    
    XCTAssertEqual(longestCommonPrefix(arr1), "fl")
    XCTAssertEqual(longestCommonPrefix(arr2), "")
  }
  
  func testPerformanceExample() throws {
    // This is an example of a performance test case.
    self.measure {
      // Put the code you want to measure the time of here.
    }
  }
  
  private func longestCommonPrefix(_ strs: [String]) -> String {
    guard let firstWord = strs.first else { return "" }
    var prefix = firstWord
    
    while strs.filter({ $0.hasPrefix(prefix) }).count != strs.count && !prefix.isEmpty {
        prefix.removeLast()
    }
    
    return prefix
}
}
