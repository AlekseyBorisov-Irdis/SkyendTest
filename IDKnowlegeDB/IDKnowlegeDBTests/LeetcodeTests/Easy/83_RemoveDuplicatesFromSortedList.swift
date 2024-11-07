//
//  RemoveDuplicatesFromSortedList.swift
//  IDKnowlegeDBTests
//
//  Created by Alexey on 07.11.2024.
//

/*
 Given the head of a sorted linked list, delete all duplicates such that each element appears only once. Return the linked list sorted as well.

 Example 1:
 Input: head = [1,1,2]
 Output: [1,2]

 Example 2:
 Input: head = [1,1,2,3,3]
 Output: [1,2,3]

 Constraints:
 The number of nodes in the list is in the range [0, 300].
 -100 <= Node.val <= 100
 The list is guaranteed to be sorted in ascending order.
 */
import XCTest

final class RemoveDuplicatesFromSortedList: LeetcodeTask {
  class ListNode {
    let val: Int
    var next: ListNode?

    init() { self.val = 0; self.next = nil; }
    init(_ val: Int) { self.val = val; self.next = nil; }
    init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }

    func getValues() -> [Int] {
      var values: [Int] = []
      var current: ListNode? = self
      while let node = current {
        values.append(node.val)
        current = node.next
      }
      return values
    }
  }

  var testCases: [TestCase]!

  struct TestCase {
    let head: ListNode
    let expected: [Int]
  }

  override func setUpWithError() throws {
    try super.setUpWithError()
    testCases = [
      TestCase(
        head: .init(1, .init(1, .init(2))),
        expected: [1, 2]
      ),
      TestCase(
        head: .init(1, .init(1, .init(2, .init(3, .init(3))))),
        expected: [1, 2, 3]
      )
    ]
  }

  override func tearDownWithError() throws {
    testCases = nil
    try super.tearDownWithError()
  }

  func testMySolution() throws {
    for testCase in testCases {
      let result = mySolution(testCase.head)
      XCTAssertEqual(result?.getValues(), testCase.expected)
    }
  }

  func testBestTimeSolution() throws {
    for testCase in testCases {
      let result = bestTimeSolution(testCase.head)
      XCTAssertEqual(result?.getValues(), testCase.expected)
    }
  }

  func testBestMemorySolution() throws {
    for testCase in testCases {
      let result = bestMemorySolution(testCase.head)
      XCTAssertEqual(result?.getValues(), testCase.expected)
    }
  }

  func testMeasureMySolution() throws {
    customMeasure {
      for testCase in testCases {
        _ = mySolution(testCase.head)
      }
    }
  }

  func testMeasureBestTimeSolution() throws {
    customMeasure {
      for testCase in testCases {
        _ = bestTimeSolution(testCase.head)
      }
    }
  }

  func testMeasureBestMemorySolution() throws {
    customMeasure {
      for testCase in testCases {
        _ = bestMemorySolution(testCase.head)
      }
    }
  }

  private func mySolution(_ head: ListNode?) -> ListNode? {
    guard let head else { return nil }
    var tail = head
    var current = head.next
    while let node = current {
      if node.val != tail.val {
        tail.next = node
        tail = node
      }
      current = node.next
    }
    tail.next = nil
    return head
  }

  // Вообще, я вроде как в лучшее время попал, но вот другой вариант
  private func bestTimeSolution(_ head: ListNode?) -> ListNode? {
    var current = head
    var last: ListNode?

    while current != nil {
      if last != nil && current!.val == last!.val {
        last?.next = current?.next
      } else {
        last = current
      }
      current = current?.next
    }

    return head
  }

  private func bestMemorySolution(_ head: ListNode?) -> ListNode? {
    let h = head
    var next = head?.next
    var head = head
    if head == nil || next == nil { return head }
    while next != nil {
      if head?.val == next?.val {
        next = next?.next
        if next == nil {
          head?.next = nil
        }
      }
      else {
        head?.next = next
        head = next
      }
    }
    return h
  }
}
