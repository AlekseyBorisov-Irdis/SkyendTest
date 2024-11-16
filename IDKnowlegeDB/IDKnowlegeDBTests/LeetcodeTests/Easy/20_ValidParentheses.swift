//
//  20_ValidParentheses.swift
//  IDKnowlegeDBTests
//
//  Created by Alexey on 18.07.2024.
//

/*
 Given a string s containing just the characters '(', ')', '{', '}', '[' and ']', determine if the input string is valid.

 An input string is valid if:
 Open brackets must be closed by the same type of brackets.
 Open brackets must be closed in the correct order.
 Every close bracket has a corresponding open bracket of the same type.

 Example 1:
 Input: s = "()"
 Output: true

 Example 2:
 Input: s = "()[]{}"
 Output: true

 Example 3:
 Input: s = "(]"
 Output: false

 Constraints:
 1 <= s.length <= 104
 s consists of parentheses only '()[]{}'.
*/

import XCTest

final class ValidParentheses: LeetcodeTask {
  // This class from leetcode
  final class Stack {
    private var stack = [Character]()
    func isEmpty() -> Bool { stack.isEmpty }
    func push(_ char: Character) { stack.append(char) }
    func pop() -> Character { return stack.removeLast() }
  }

  struct TestCase {
    let data: String
    let result: Bool
  }

  private var testCases: [TestCase]!

  override func setUpWithError() throws {
    try super.setUpWithError()
    testCases = [
      TestCase(
        data: "()",
        result: true
      ),
      TestCase(
        data: "()[]{}",
        result: true
      ),
      TestCase(
        data: "(]",
        result: false
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
        mySolution(data: testCase.data),
        testCase.result
      )
    }
  }

  func testBestTimeSolution() throws {
    for testCase in testCases {
      XCTAssertEqual(
        bestTimeSolution(data: testCase.data),
        testCase.result
      )
    }
  }

  func testBestMemorySolution() throws {
    for testCase in testCases {
      XCTAssertEqual(
        bestMemorySolution(data: testCase.data),
        testCase.result
      )
    }
  }

  func testMeasureMySolution() throws {
    customMeasure {
      _ = testCases.map { mySolution(data: $0.data) }
    }
  }

  func testMeasureBestTimeSolution() throws {
    customMeasure {
      _ = testCases.map { bestTimeSolution(data: $0.data) }
    }
  }

  func testMeasureBestMemorySolution() throws {
    customMeasure {
      _ = testCases.map { bestMemorySolution(data: $0.data) }
    }
  }

  private func mySolution(data: String) -> Bool {
    let available: [Character: Character] = ["(": ")", "{": "}", "[": "]"]
    var validOrder = [Character]()
    for char in data {
      if available.values.contains(char) {
        guard let lastOrder = validOrder.last else { return false }
        guard char == lastOrder else { return false }
        validOrder.removeLast()
      }

      if available.keys.contains(char) {
        guard let closingChar = available[char] else { return false }
        validOrder.append(closingChar)
      }
    }

    return validOrder.isEmpty
  }

  private func bestTimeSolution(data: String) -> Bool {
    guard data.count % 2 == 0 || data.count > 1 else { return false }

    var stack = [Character]()
    let dict: [Character: Character] = [")": "(", "}": "{", "]": "["]

    for c in data {
      if !stack.isEmpty, dict.keys.contains(c), let pair = dict[c], pair == stack.last {
        _ = stack.popLast()
      } else {
        stack.append(c)
      }
    }

    return stack.isEmpty
  }

  private func bestMemorySolution(data: String) -> Bool {
    if data.count < 2 {
      return false
    }

    let openingBrackets: [Character] = ["(", "{", "["]
    let stack = Stack()
    for char in data {
      if openingBrackets.contains(char) {
        stack.push(char)
      } else {
        if stack.isEmpty() {
          return false
        }
        let bracket = stack.pop()
        if char == ")" && bracket == "(" {}
        else if char == "}" && bracket == "{" {}
        else if char == "]" && bracket == "[" {}
        else {
          return false
        }
      }
    }

    if !stack.isEmpty() {
      return false
    } else {
      return true
    }
  }
}
