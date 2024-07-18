//
//  9_PalindromeNumber.swift
//  IDKnowlegeDBTests
//
//  Created by Alexey on 13.07.2024.
//

/*
 Given an integer x, return true if x is a palindrome, and false otherwise.

 Example 1:
 Input: x = 121
 Output: true
 Explanation: 121 reads as 121 from left to right and from right to left.

 Example 2:
 Input: x = -121
 Output: false
 Explanation: From left to right, it reads -121. From right to left, it becomes 121-. Therefore it is not a palindrome.

 Example 3:
 Input: x = 10
 Output: false
 Explanation: Reads 01 from right to left. Therefore it is not a palindrome.

 Constraints:
 -2^31 <= x <= 2^31 - 1
 */

import XCTest

final class PalindromeNumber: LeetcodeTask {
  struct TestCase {
    let target: Int
    let resuslt: Bool
  }

  var testCases: [TestCase]!

  override func setUpWithError() throws {
    try super.setUpWithError()
    testCases = [
      TestCase(
        target: 121,
        resuslt: true
      ),
      TestCase(
        target: -121,
        resuslt: false
      ),
      TestCase(
        target: 1,
        resuslt: true
      ),
      TestCase(
        target: 123454321,
        resuslt: true
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
        mySolution(testCase.target),
        testCase.resuslt
      )
    }
  }

  func testBestTimeSolution() throws {
    func testBestTimeSolution() throws {
      for testCase in testCases {
        XCTAssertEqual(
          bestTimeSolution(testCase.target),
          testCase.resuslt
        )
      }
    }
  }

  func testBestMemorySolution() throws {
    for testCase in testCases {
      XCTAssertEqual(
        bestMemorySolution(testCase.target),
        testCase.resuslt
      )
    }
  }

  func testMeasureMySolution() throws {
    customMeasure {
      _ = testCases.map { mySolution($0.target) }
    }
  }

  func testMeasureBestTimeSolution() throws {
    customMeasure {
      _ = testCases.map { bestTimeSolution($0.target) }
    }
  }

  func testMeasureBestMemorySolution() throws {
    customMeasure {
      _ = testCases.map { bestMemorySolution($0.target) }
    }
  }

  private func mySolution(_ x: Int) -> Bool {
    if x == 0 { return true }
    if x < 0 || x%10 == 0 { return false }

    var reversedNum = 0
    var num = x
    while num > 0 {
      let digit = num % 10
      reversedNum = (reversedNum * 10) + digit
      num /= 10
    }

    return x == reversedNum
  }

  private func bestTimeSolution(_ x: Int) -> Bool  {
    func method(x: Int) -> Int {
      var r = 0
      var x = x
      while x != 0 {
        r = r * 10
        r = r + x % 10
        x /= 10
      }
      return (r < Int32.min || r > Int32.max) ? 0 : r
    }

    return x < 0 ? false : method(x: x) == x
  }

  private func bestMemorySolution(_ x: Int) -> Bool  {
    if x < 0 { return false }
    var xCopy = x
    var mirrored = 0
    while xCopy > 0 {
      mirrored = mirrored * 10 + xCopy % 10
      xCopy = xCopy / 10
    }

    return x == mirrored
  }
}
