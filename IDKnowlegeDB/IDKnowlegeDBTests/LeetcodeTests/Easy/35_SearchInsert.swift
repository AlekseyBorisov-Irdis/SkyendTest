//
//  35_SearchInsert.swift
//  IDKnowlegeDBTests
//
//  Created by Alexey on 09.07.2024.
//

/*
 Given a sorted array of distinct integers and a target value, return the index if the target is found. If not, return the index where it would be if it were inserted in order.
 You must write an algorithm with O(log n) runtime complexity.

 Example 1:
 Input: nums = [1,3,5,6], target = 5
 Output: 2

 Example 2:
 Input: nums = [1,3,5,6], target = 2
 Output: 1

 Example 3:
 Input: nums = [1,3,5,6], target = 7
 Output: 4
 */

import XCTest

final class SearchInsert: LeetcodeTask {
  struct TestCase {
    let array: [Int]
    let target: Int
    let resuslt: Int
  }

  private var testCases: [TestCase]!
  
  override func setUpWithError() throws {
    try super.setUpWithError()
    testCases = [
      TestCase(
        array: [1,3,5,6],
        target: 5,
        resuslt: 2
      ),
      TestCase(
        array: [1,3,5,6],
        target: 2,
        resuslt: 1
      ),
      TestCase(
        array: [1,3,5,6],
        target: 7,
        resuslt: 4
      ),
      TestCase(
        array: [1],
        target: 2,
        resuslt: 1
      ),
      TestCase(
        array: [1],
        target: 1,
        resuslt: 0
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
        ),
        testCase.resuslt
      )
    }
  }

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

  func testPerformanceMySolution() throws {
    customMeasure {
      _ = testCases.map { mySolution(nums: $0.array, target: $0.target) }
    }
  }

  func testPerformanceBestTimeSolution() throws {
    customMeasure {
      _ = testCases.map { bestTimeSolution(nums: $0.array, target: $0.target) }
    }
  }

  func testPerformanceBestMemorySolution() throws {
    customMeasure {
      _ = testCases.map { bestMemorySolution(nums: $0.array, target: $0.target) }
    }
  }

  private func mySolution(
    nums: [Int],
    target: Int
  ) -> Int {
    guard !nums.isEmpty else { return 0 }

    var lowerBound = 0
    var upperBound = nums.count
    while lowerBound < upperBound {
      let midIndex = lowerBound + (upperBound - lowerBound) / 2
      if nums[midIndex] == target {
        return midIndex
      } else if nums[midIndex] < target {
        lowerBound = midIndex + 1
      } else {
        upperBound = midIndex
      }
    }
    return lowerBound
  }

  private func bestTimeSolution(
    nums: [Int],
    target: Int
  ) -> Int {
    var left = 0
    var right = nums.count - 1
    var mid = 0

    while(left < right) {
        mid = (left + right) / 2

        if(nums[mid] < target) {
            left = mid + 1
        } else {
            right = mid
        }
    }

    if(nums[left] >= target) {
        return left
    } else {
        return left + 1
    }
  }

  private func bestMemorySolution(
    nums: [Int],
    target: Int
  ) -> Int {
    var index = 0
    for (indice, elemento) in nums.enumerated() {
        let aux = elemento
        if elemento == target {
            index = indice
        } else if aux < target {
            index = indice + 1
        }
    }
    return index
  }
}
