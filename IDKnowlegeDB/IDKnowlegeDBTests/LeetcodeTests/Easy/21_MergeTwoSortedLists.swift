//
//  21_MergeTwoSortedLists.swift
//  IDKnowlegeDBTests
//
//  Created by Alexey on 18.07.2024.
//

/*
 You are given the heads of two sorted linked lists list1 and list2.
 Merge the two lists into one sorted list. The list should be made by splicing together the nodes of the first two lists.
 Return the head of the merged linked list.

 Example 1:
 Input: list1 = [1,2,4], list2 = [1,3,4]
 Output: [1,1,2,3,4,4]

 Example 2:
 Input: list1 = [], list2 = []
 Output: []

 Example 3:
 Input: list1 = [], list2 = [0]
 Output: [0]

 Constraints:
 The number of nodes in both lists is in the range [0, 50].
 -100 <= Node.val <= 100
 Both list1 and list2 are sorted in non-decreasing order.
*/

import XCTest

final class MergeTwoSortedLists: LeetcodeTask {
  class ListNode {
    public var val: Int
    public var next: ListNode?
    public init() { self.val = 0; self.next = nil; }
    public init(_ val: Int) { self.val = val; self.next = nil; }
    public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
  }

  struct TestCase {
    let data: ListNode?
    let target: ListNode?
    let result: ListNode?
  }

  var testCases: [TestCase]!

  override func setUpWithError() throws {
    try super.setUpWithError()
    testCases = [
      TestCase(
        data: ListNode(1, ListNode(2, ListNode(4, nil))),
        target: ListNode(1, ListNode(3, ListNode(4, nil))),
        result: ListNode(1, ListNode(1, ListNode(2, ListNode(3, ListNode(4, ListNode(4))))))
      ),
      TestCase(
        data: nil,
        target: nil,
        result: nil
      ),
      TestCase(
        data: nil,
        target: ListNode(0),
        result: ListNode(0)
      )
    ]
  }

  override func tearDownWithError() throws {
    testCases = nil
    try super.tearDownWithError()
  }

  func testMySolution() throws {
    for testCase in testCases {
      XCTAssertEqual(
        valuesSumString(of: mySolution(data: testCase.data, target: testCase.target)),
        valuesSumString(of: testCase.result)
      )
    }
  }

  func testBestTimeSolution() throws {
    for testCase in testCases {
      XCTAssertEqual(
        valuesSumString(of: bestTimeSolution(data: testCase.data, target: testCase.target)),
        valuesSumString(of: testCase.result)
      )
    }
  }

  func testBestMemorySolution() throws {
    for testCase in testCases {
      XCTAssertEqual(
        valuesSumString(of: bestMemorySolution(data: testCase.data, target: testCase.target)),
        valuesSumString(of: testCase.result)
      )
    }
  }

  func testMeasureMySolution() throws {
    customMeasure {
      _ = testCases.map { mySolution(data: $0.data, target: $0.target) }
    }
  }

  func testMeasureBestTimeSolution() throws {
    customMeasure {
      _ = testCases.map { bestTimeSolution(data: $0.data, target: $0.target) }
    }
  }

  func testMeasureBestMemorySolution() throws {
    customMeasure {
      _ = testCases.map { bestMemorySolution(data: $0.data, target: $0.target) }
    }
  }

  private func mySolution(data: ListNode?, target: ListNode?) -> ListNode? {
    guard let data, let target else { return data ?? target }
    if data.val <= target.val {
      data.next = mySolution(data: data.next, target: target)
      return data
    } else {
      target.next = mySolution(data: data, target: target.next)
      return target
    }
  }

  private func bestTimeSolution(data: ListNode?, target: ListNode?) -> ListNode? {
    guard let list1 = data else { return target }
    guard let list2 = target else { return data }

    var mergedHead: ListNode?
    var mergedTail: ListNode?

    if list1.val < list2.val {
      mergedHead = list1
      mergedTail = bestTimeSolution(data: list1.next, target: list2)
    } else {
      mergedHead = list2
      mergedTail = bestTimeSolution(data: list1, target: list2.next)
    }

    mergedHead?.next = mergedTail

    return mergedHead
  }

  private func bestMemorySolution(data: ListNode?, target: ListNode?) -> ListNode? {
    guard let l1 = data, let l2 = target else { return data ?? target }

    if l1.val <= l2.val {
      l1.next = bestMemorySolution(data: l1.next, target: l2)
        return l1
    } else {
      l2.next = bestMemorySolution(data: l1, target: l2.next)
        return l2
    }
  }

  private func valuesSumString(of listNode: ListNode?) -> String {
    guard let node = listNode else { return "" }

    return String(node.val) + valuesSumString(of: node.next)
  }
}
