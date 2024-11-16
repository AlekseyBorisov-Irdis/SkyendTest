//
//  1_TwoSum.swift
//  IDKnowlegeDBTests
//
//  Created by Alexey on 12.07.2024.
//

/*
 Given an array of integers nums and an integer target, return indices of the two numbers such that they add up to target.
 You may assume that each input would have exactly one solution, and you may not use the same element twice.
 You can return the answer in any order.

 Example 1:
 Input: nums = [2,7,11,15], target = 9
 Output: [0,1]
 Explanation: Because nums[0] + nums[1] == 9, we return [0, 1].

 Example 2:
 Input: nums = [3,2,4], target = 6
 Output: [1,2]

 Example 3:
 Input: nums = [3,3], target = 6
 Output: [0,1]

 Constraints:

 2 <= nums.length <= 104
 -109 <= nums[i] <= 109
 -109 <= target <= 109
 Only one valid answer exists.
 */

import XCTest

final class TwoSum: LeetcodeTask {
  struct TestCase {
    let array: [Int]
    let target: Int
    let resuslt: [Int]
  }

  private var testCases: [TestCase]!

  override func setUpWithError() throws {
    try super.setUpWithError()
    testCases = [
      TestCase(
        array: [2, 7, 11, 15],
        target: 9,
        resuslt: [0, 1]
      ),
      TestCase(
        array: [3, 2, 4],
        target: 6,
        resuslt: [1, 2]
      ),
      TestCase(
        array: [3, 3],
        target: 6,
        resuslt: [0, 1]
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
        mySolution(
          nums: testCase.array,
          target: testCase.target
        ).sorted(by: <),
        testCase.resuslt
      )
    }
  }

  func testBestTimeSolution() throws {
    func testBestTimeSolution() throws {
      for testCase in testCases {
        XCTAssertEqual(
          bestTimeSolution(
            nums: testCase.array,
            target: testCase.target
          ),
          testCase.resuslt
        )
      }
    }
  }

  func testBestMemorySolution() throws {
    for testCase in testCases {
      XCTAssertEqual(
        bestMemorySolution(
          nums: testCase.array,
          target: testCase.target
        ),
        testCase.resuslt
      )
    }
  }

  func testMeasureMySolution() throws {
    customMeasure {
      _ = testCases.map { mySolution(nums: $0.array, target: $0.target) }
    }
  }

  func testMeasureBestTimeSolution() throws {
    customMeasure {
      _ = testCases.map { bestTimeSolution(nums: $0.array, target: $0.target) }
    }
  }

  func testMeasureBestMemorySolution() throws {
    customMeasure {
      _ = testCases.map { bestMemorySolution(nums: $0.array, target: $0.target) }
    }
  }
  
  // O(n)
  private func mySolution(nums: [Int], target: Int) -> [Int] {
    var dictionary = Dictionary<Int, Int>()

    for num in nums.enumerated() {
      if let remains = dictionary[target - num.element] {
        return [num.offset, remains]
      } else {
        dictionary[num.element] = num.offset
      }
    }

    return []
  }
  
  // O(n)
  private func bestTimeSolution(nums: [Int], target: Int) -> [Int] {
    var seen = [Int: Int]()
    for (i, _) in nums.enumerated() {
      let diff = target - nums[i]
      if let index = seen[diff] {
        return [index, i]
      } else {
        seen[nums[i]] = i
      }
    }
    return []
  }

  // O(n^2)
  private func bestMemorySolution(nums: [Int], target: Int) -> [Int] {
    // Set array size to a constant
    let lengthOfArray = nums.count

    // Iterate through the array once to get the first index
    for index in 0...lengthOfArray - 1 {
      // Iterate again to get the second index
      for secondIndex in index + 1 ..< lengthOfArray {
        // Check if the target has been reached
        if nums[index] + nums[secondIndex] == target {
          return [index, secondIndex]
        }
      }
    }
    return []
  }
}
