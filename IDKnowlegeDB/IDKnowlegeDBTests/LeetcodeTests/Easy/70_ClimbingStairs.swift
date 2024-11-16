//
//  ClimbingStairs.swift
//  IDKnowlegeDBTests
//
//  Created by Alexey on 07.11.2024.
//

/*
 You are climbing a staircase. It takes n steps to reach the top.
 Each time you can either climb 1 or 2 steps. In how many distinct ways can you climb to the top?

 Example 1:
 Input: n = 2
 Output: 2
 Explanation: There are two ways to climb to the top.
 1. 1 step + 1 step
 2. 2 steps

 Example 2:
 Input: n = 3
 Output: 3
 Explanation: There are three ways to climb to the top.
 1. 1 step + 1 step + 1 step
 2. 1 step + 2 steps
 3. 2 steps + 1 step

 Constraints:
 1 <= n <= 45
 */

import XCTest

final class ClimbingStairs: LeetcodeTask {
  struct TestCase {
    let input: Int
    let expected: Int
  }

  private var testCases: [TestCase]!

  override func setUpWithError() throws {
    try super.setUpWithError()
    testCases = [
      TestCase(input: 2, expected: 2),
      TestCase(input: 3, expected: 3),
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

  func textMeasureBestTimeSolution() throws {
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

  private func mySolution(_ n: Int) -> Int {
    var functionResult: [Int: Int] = [1: 1, 2 : 2]

    func fN(_ n: Int) -> Int {
      guard n > 0 else { return 0 }

      if let result = functionResult[n] { return result } else {
        let newResult = fN(n-1) + fN(n-2)
        functionResult[n] = newResult
        return newResult
      }
    }

    return fN(n)
  }

  private func bestTimeSolution(_ n: Int) -> Int {
    guard n > 3 else { return n }
    var dp = Array(repeating: 0, count: n + 1)
    dp[1] = 1
    dp[2] = 2
    dp[3] = 3

    for i in 4 ... n {
      dp[i] = dp[i - 1] + dp[i - 2]
    }
    return dp[n]
  }

  private func bestMemorySolution(_ n: Int) -> Int {
    var last: Int = 1
    var ans: Int = 0

    for _ in 0...n {
      let temp: Int = ans + last
      last = ans
      ans = temp
    }

    return ans
  }
}
