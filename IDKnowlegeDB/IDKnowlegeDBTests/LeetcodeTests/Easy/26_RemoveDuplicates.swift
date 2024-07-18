//
//  26_RemoveDuplicates.swift
//  IDKnowlegeDBTests
//
//  Created by Alexey on 18.07.2024.
//

/*
 Given an integer array nums sorted in non-decreasing order, remove the duplicates in-place such that each unique element appears only once. The relative order of the elements should be kept the same. Then return the number of unique elements in nums.

 Consider the number of unique elements of nums to be k, to get accepted, you need to do the following things:

 Change the array nums such that the first k elements of nums contain the unique elements in the order they were present in nums initially. The remaining elements of nums are not important as well as the size of nums.
 Return k.
 Custom Judge:

 The judge will test your solution with the following code:

 int[] nums = [...]; // Input array
 int[] expectedNums = [...]; // The expected answer with correct length
 int k = removeDuplicates(nums); // Calls your implementation
 assert k == expectedNums.length;
 for (int i = 0; i < k; i++) {
     assert nums[i] == expectedNums[i];
 }

 If all assertions pass, then your solution will be accepted.

 Example 1:
 Input: nums = [1,1,2]
 Output: 2, nums = [1,2,_]
 Explanation: Your function should return k = 2, with the first two elements of nums being 1 and 2 respectively.
 It does not matter what you leave beyond the returned k (hence they are underscores).

 Example 2:
 Input: nums = [0,0,1,1,1,2,2,3,3,4]
 Output: 5, nums = [0,1,2,3,4,_,_,_,_,_]
 Explanation: Your function should return k = 5, with the first five elements of nums being 0, 1, 2, 3, and 4 respectively.
 It does not matter what you leave beyond the returned k (hence they are underscores).

 Constraints:
 1 <= nums.length <= 3 * 104
 -100 <= nums[i] <= 100
 nums is sorted in non-decreasing order.
*/

import XCTest

final class RemoveDuplicates: LeetcodeTask {
  struct TestCase {
    let nums: [Int]
    let result: Int
  }

  var testCases: [TestCase]!

  override func setUpWithError() throws {
    try super.setUpWithError()
    testCases = [
      TestCase(
        nums: [1,1,2],
        result: 2
      ),
      TestCase(
        nums: [0,0,1,1,1,2,2,3,3,4],
        result: 5
      )
    ]
  }

  override func tearDownWithError() throws {
    testCases = nil
    try super.tearDownWithError()
  }

  func testMySolution() throws {
    for testCase in testCases {
      var nums = testCase.nums
      XCTAssertEqual(
        mySolution(&nums),
        testCase.result
      )
    }
  }

  func testBestTimeSolution() throws {
    for testCase in testCases {
      var nums = testCase.nums
      XCTAssertEqual(
        bestTimeSolution(&nums),
        testCase.result
      )
    }
  }

  func testBestMemorySolution() throws {
    for testCase in testCases {
      var nums = testCase.nums
      XCTAssertEqual(
        bestMemorySolution(&nums),
        testCase.result
      )
    }
  }

  func testMeasureMySolution() throws {
    customMeasure {
      _ = testCases.map {
        var nums = $0.nums
        _ = mySolution(&nums)
      }
    }
  }

  func testMeasureBestTimeSolution() throws {
    customMeasure {
      _ = testCases.map {
        var nums = $0.nums
        _ = bestTimeSolution(&nums)
      }
    }
  }

  func testMeasureBestMemorySolution() throws {
    customMeasure {
      _ = testCases.map {
        var nums = $0.nums
        _ = bestMemorySolution(&nums)
      }
    }
  }

  private func mySolution(_ nums: inout [Int]) -> Int {
    Array(Set(nums)).sorted().count
  }

  private func bestTimeSolution(_ nums: inout [Int]) -> Int {
    var k = 1

    for i in 1..<nums.count {
      if nums[i] != nums[k - 1] {
        nums[k] = nums[i]
        k += 1
      }
    }

    return k
  }

  private func bestMemorySolution(_ nums: inout [Int]) -> Int {
    var result = [Int]()

    for num in nums {
      if !result.contains(num) {
        result.append(num)
      }
    }

    nums = result
    return result.count
  }
}
