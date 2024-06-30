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
  
  func testValidParentheses() throws {
    let string1 = "sdfgfdg(dsfdsgfd{sdfdsfs[dsfdsfs]sdfsfbvb}sdfdvsvs)sdfsl;"
    let string2 = "sd}()fdjskl"
    let string3 = "(){}[]"
    let string4 = "(){}[]{"
    let string5 = "(){{}[]"

    XCTAssertTrue(isValidParentheses(string1))
    XCTAssertFalse(isValidParentheses(string2))
    XCTAssertTrue(isValidParentheses(string3))
    XCTAssertFalse(isValidParentheses(string4))
    XCTAssertFalse(isValidParentheses(string5))
  }

  func testMergeTwoList() throws {
    let list1 = ListNode(1, ListNode(2, ListNode(4, nil)))
    let list2 = ListNode(1, ListNode(3, ListNode(4, nil)))

    let result = mergeTwoLists(list1, list2)
    XCTAssertEqual(valuesSumString(of: result), "112344")
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

  private func isValidParentheses(_ string: String) -> Bool {
    let available: [Character: Character] = ["(": ")", "{": "}", "[": "]"]
    var validOrder = [Character]()
    for char in string {
      if available.values.contains(char) {
        guard let lastOrder = validOrder.last else { return false }
        guard char == lastOrder else { return false }
        validOrder.removeLast()
      }

      if available.keys.contains(char) {
        guard let closingChar = available[char] else {
          continue
        }
        validOrder.append(closingChar)
      }
    }

    return validOrder.isEmpty
  }

  private func mergeTwoLists(
    _ list1: ListNode?,
    _ list2: ListNode?
  ) -> ListNode? {
    if list1 == nil || list2 == nil {
      return list1 == nil ? list2 : list1
    }
    if list1!.val <= list2!.val {
      list1?.next = mergeTwoLists(list1?.next, list2)
      return list1
    } else {
      list2?.next = mergeTwoLists(list1, list2?.next)
      return list2
    }
  }

  private func valuesSumString(of listNode: ListNode?) -> String {
    guard let node = listNode else { return "" }

    return String(node.val) + valuesSumString(of: node.next)
  }
}
