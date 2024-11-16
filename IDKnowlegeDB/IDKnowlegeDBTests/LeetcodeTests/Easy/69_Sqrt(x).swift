//
//  Sqrt(x).swift
//  IDKnowlegeDBTests
//
//  Created by Alexey on 06.11.2024.
//

/*
 Given a non-negative integer x, return the square root of x rounded down to the nearest integer. The returned integer should be non-negative as well.
 You must not use any built-in exponent function or operator.
 For example, do not use pow(x, 0.5) in c++ or x ** 0.5 in python.

 Example 1:
 Input: x = 4
 Output: 2
 Explanation: The square root of 4 is 2, so we return 2.

 Example 2:
 Input: x = 8
 Output: 2
 Explanation: The square root of 8 is 2.82842..., and since we round it down to the nearest integer, 2 is returned.

 Constraints:
 0 <= x <= 231 - 1
 */

import XCTest

final class SqrtX: LeetcodeTask {
  struct TestCase {
    let input: Int
    let expected: Int
  }

  private var testCases: [TestCase]!

  override func setUpWithError() throws {
    try super.setUpWithError()
    testCases = [
      TestCase(input: 4, expected: 2),
      TestCase(input: 8, expected: 2),
      TestCase(input: 100, expected: 10),
      TestCase(input: 2147483647, expected: 46340)
    ]
  }

  override func tearDownWithError() throws {
    testCases = nil
    try super.tearDownWithError()
  }

  func testMySolution() throws {
    for testCase in testCases {
      let result = mySolution(testCase.input)
      XCTAssertEqual(result, testCase.expected)
    }
  }

  func testMeasureMySolution() throws {
    customMeasure {
      for testCase in testCases {
        _ = mySolution(testCase.input)
      }
    }
  }

  func testBestTimeSolution() throws {
    for testCase in testCases {
      let result = bestTimeSolution(testCase.input)
      XCTAssertEqual(result, testCase.expected)
    }
  }

  func testMeasureBestTimeSolution() throws {
    customMeasure {
      for testCase in testCases {
        _ = bestTimeSolution(testCase.input)
      }
    }
  }

  func testBestMemorySolution() throws {
    for testCase in testCases {
      let result = bestMemorySolution(testCase.input)
      XCTAssertEqual(result, testCase.expected)
    }
  }

  func testMeasureBestMemorySolution() throws {
    customMeasure {
      for testCase in testCases {
        _ = bestMemorySolution(testCase.input)
      }
    }
  }

  private func mySolution(_ x: Int) -> Int {
    var result: Int = 0
    var low = 0
    var high = x

    while low <= high {
      let mid = (low + high) / 2
      if mid == 0 { return x }
      let square = mid * mid
      if square < x {
        result = mid
        low = mid + 1
      } else if square > x {
        high = mid - 1
      } else {
        return mid
      }
    }

    return result
  }

  private func bestTimeSolution(_ x: Int) -> Int {
    var left = 0
    var right = x
    var ans = 0

    while left <= right {
      let mid = (left + right) / 2
      if mid * mid <= x {
        ans = mid
        left = mid + 1
      } else {
        right = mid - 1
      }
    }

    return ans
  }

  private func bestMemorySolution(_ x: Int) -> Int {
    var lo = 0
    var hi = x

    while lo <= hi {
      let mid = lo + (hi - lo) / 2
      if mid * mid == x {
        return mid
      } else if mid * mid < x {
        lo = mid + 1
      } else {
        hi = mid - 1
      }
    }
    return hi
  }
}
