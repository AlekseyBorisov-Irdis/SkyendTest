//
//  66_PlusOne.swift
//  IDKnowlegeDBTests
//
//  Created by Alexey on 18.07.2024.
//

/*
 You are given a large integer represented as an integer array digits, where each digits[i] is the ith digit of the integer. The digits are ordered from most significant to least significant in left-to-right order. The large integer does not contain any leading 0's.
 Increment the large integer by one and return the resulting array of digits.

 Example 1:
 Input: digits = [1,2,3]
 Output: [1,2,4]
 Explanation: The array represents the integer 123.
 Incrementing by one gives 123 + 1 = 124.
 Thus, the result should be [1,2,4].

 Example 2:
 Input: digits = [4,3,2,1]
 Output: [4,3,2,2]
 Explanation: The array represents the integer 4321.
 Incrementing by one gives 4321 + 1 = 4322.
 Thus, the result should be [4,3,2,2].

 Example 3:
 Input: digits = [9]
 Output: [1,0]
 Explanation: The array represents the integer 9.
 Incrementing by one gives 9 + 1 = 10.
 Thus, the result should be [1,0].

 Constraints:
 1 <= digits.length <= 100
 0 <= digits[i] <= 9
 digits does not contain any leading 0's.
*/

import XCTest

final class PlusOne: LeetcodeTask {
  struct TestCase {
    let digits: [Int]
    let result: [Int]
  }

  private var testCases: [TestCase]!

  override func setUpWithError() throws {
    try super.setUpWithError()
    testCases = [
      TestCase(
        digits: [1, 2, 3],
        result: [1, 2, 4]
      ),
      TestCase(
        digits: [4,3,2,1],
        result: [4,3,2,2]
      ),
      TestCase(
        digits: [9],
        result: [1, 0]
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
        mySolution(testCase.digits),
        testCase.result
      )
    }
  }

  func testBestTimeSolution() throws {
    for testCase in testCases {
      XCTAssertEqual(
        bestTimeSolution(testCase.digits),
        testCase.result
      )
    }
  }

  func testBestMemorySolution() throws {
    for testCase in testCases {
      XCTAssertEqual(
        bestMemorySolution(testCase.digits),
        testCase.result
      )
    }
  }

  func testMeasureMySolution() throws {
    customMeasure {
      _ = testCases.map { mySolution($0.digits) }
    }
  }

  func testMeasureBestTimeSolution() throws {
    customMeasure {
      _ = testCases.map { bestTimeSolution($0.digits) }
    }
  }

  func testMeasureBestMemorySolution() throws {
    customMeasure {
      _ = testCases.map { bestMemorySolution($0.digits) }
    }
  }

  private func mySolution(_ digits: [Int]) -> [Int] {
    var result = digits
    var register = digits.count - 1
    var needToRiseRegister = true
    while needToRiseRegister {
      let number = digits[register] + 1
      if number > 9 {
        result[register] = 0
        if register == 0 {
          result.insert(1, at: 0)
          needToRiseRegister = false
        }
        register -= 1
      } else {
        result[register] = number
        needToRiseRegister = false
      }
    }
    return result
  }

  private func bestTimeSolution(_ digits: [Int]) -> [Int] {
    var digits = digits
    let n = digits.count

    for i in (0 ..< n).reversed() {
      if digits[i] < 9 {
        digits[i] += 1
        return digits
      }
      digits[i] = 0
    }
    digits.insert(1, at: 0)
    return digits
  }

  private func bestMemorySolution(_ digits: [Int]) -> [Int] {
    var digits = digits // Make a mutable copy of input

    // Iterate from rightmost digit to left
    for i in (0..<digits.count).reversed() {
      // Increment current digit
      digits[i] += 1

      // If no carry, return digits immediately
      if digits[i] < 10 {
        return digits
      }

      // If there's a carry, set current digit to 0 and continue to next digit
      digits[i] = 0
    }

    // If we're here, it means there was a carry all the way to the leftmost digit
    // Create a new array with one additional digit (1 followed by zeros)
    return [1] + digits
  }
}
