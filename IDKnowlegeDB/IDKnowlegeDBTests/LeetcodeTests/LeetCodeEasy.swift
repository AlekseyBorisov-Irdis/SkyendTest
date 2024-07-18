//
//  LeetCodeEasy.swift
//  IDKnowlegeDBTests
//
//  Created by Alexey on 28.06.2024.
//

import Foundation
import XCTest
@testable import IDKnowlegeDB

class ListNode {
  public var val: Int
  public var next: ListNode?
  public init() { self.val = 0; self.next = nil; }
  public init(_ val: Int) { self.val = val; self.next = nil; }
  public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
}

final class LeetCodeEasy: XCTestCase {
  override func setUpWithError() throws {

  }
  
  override func tearDownWithError() throws {
   
  }

  func testPerformanceExample() throws {
    // This is an example of a performance test case.
    self.measure {
      // Put the code you want to measure the time of here.
    }
  }
  
  func testRemoveDuplicates() throws {
    var arr1 = [1,1,2]
    var arr2 = [0,0,1,1,1,2,2,3,3,4]
    var arr3 = [Int]()
    var arr4 = [1, 1]

    XCTAssertEqual(removeDuplicates(&arr1), 2)
    XCTAssertEqual(arr1, [1,2])
    XCTAssertEqual(removeDuplicates(&arr2), 5)
    XCTAssertEqual(arr2, [0,1,2,3,4])
    XCTAssertEqual(removeDuplicates(&arr3), 0)
    XCTAssertEqual(arr3, [Int]())
    XCTAssertEqual(removeDuplicates(&arr4), 1)
    XCTAssertEqual(arr4, [1])
  }

  private func removeDuplicates(_ nums: inout [Int]) -> Int {
    nums = Array(Set(nums)).sorted()
    return nums.count
  }
}
