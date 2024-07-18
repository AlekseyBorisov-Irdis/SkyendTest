//
//  27_RemoveDuplicates.swift
//  IDKnowlegeDBTests
//
//  Created by Alexey on 18.07.2024.
//

/*
 Given an integer array nums and an integer val, remove all occurrences of val in nums in-place. The order of the elements may be changed. Then return the number of elements in nums which are not equal to val.
 Consider the number of elements in nums which are not equal to val be k, to get accepted, you need to do the following things:

 Change the array nums such that the first k elements of nums contain the elements which are not equal to val. The remaining elements of nums are not important as well as the size of nums.
 Return k.
 Custom Judge:

 The judge will test your solution with the following code:

 int[] nums = [...]; // Input array
 int val = ...; // Value to remove
 int[] expectedNums = [...]; // The expected answer with correct length.
                             // It is sorted with no values equaling val.

 int k = removeElement(nums, val); // Calls your implementation

 assert k == expectedNums.length;
 sort(nums, 0, k); // Sort the first k elements of nums
 for (int i = 0; i < actualLength; i++) {
     assert nums[i] == expectedNums[i];
 }

 If all assertions pass, then your solution will be accepted.

 Example 1:
 Input: nums = [3,2,2,3], val = 3
 Output: 2, nums = [2,2,_,_]
 Explanation: Your function should return k = 2, with the first two elements of nums being 2.
 It does not matter what you leave beyond the returned k (hence they are underscores).

 Example 2:
 Input: nums = [0,1,2,2,3,0,4,2], val = 2
 Output: 5, nums = [0,1,4,0,3,_,_,_]
 Explanation: Your function should return k = 5, with the first five elements of nums containing 0, 0, 1, 3, and 4.

 Note that the five elements can be returned in any order.
 It does not matter what you leave beyond the returned k (hence they are underscores).


 Constraints:
 0 <= nums.length <= 100
 0 <= nums[i] <= 50
 0 <= val <= 100
*/

import XCTest

final class RemoveElement: LeetcodeTask {
  struct TestCase {
    let nums: [Int]
    let val: Int
    let result: Int
  }

  var testCases: [TestCase]!

  override func setUpWithError() throws {
    try super.setUpWithError()
    testCases = [
      TestCase(
        nums: [3,2,2,3],
        val: 3,
        result: 2
      ),
      TestCase(
        nums: [0,1,2,2,3,0,4,2],
        val: 2,
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
        mySolution(&nums, testCase.val),
        testCase.result
      )
    }
  }

  func testBestTimeSolution() throws {
    for testCase in testCases {
      var nums = testCase.nums
      XCTAssertEqual(
        bestTimeSolution(&nums, testCase.val),
        testCase.result
      )
    }
  }

  func testBestMemorySolution() throws {
    for testCase in testCases {
      var nums = testCase.nums
      XCTAssertEqual(
        bestMemorySolution(&nums, testCase.val),
        testCase.result
      )
    }
  }

  func testMeasureMySolution() throws {
    customMeasure {
      _ = testCases.map {
        var nums = $0.nums
        _ = mySolution(&nums, $0.val) }
    }
  }

  func testMeasureBestTimeSolution() throws {
    customMeasure {
      _ = testCases.map { 
        var nums = $0.nums
        _ = bestTimeSolution(&nums, $0.val) }
    }
  }

  func testMeasureBestMemorySolution() throws {
    customMeasure {
      _ = testCases.map {
        var nums = $0.nums
        _ = bestMemorySolution(&nums, $0.val) }
    }
  }

  private func mySolution(_ nums: inout [Int], _ val: Int) -> Int {
    nums = nums.filter({ $0 != val })
    return nums.count
  }

  private func bestTimeSolution(_ nums: inout [Int], _ val: Int) -> Int {
    var expectedResult: [Int] = []

    for num in nums where num != val {
      expectedResult.append(num)
    }

    nums = expectedResult

    return expectedResult.count
  }

  private func bestMemorySolution(_ nums: inout [Int], _ val: Int) -> Int {
    var k = 0
    for x in nums {
      if x != val{
        k += 1
      }
    }

    //another approach
    var index = 0 // for final values
    var i = 0 //for traversal

    while index < k {
      if nums[i] != val {
        nums[index] = nums[i]
        index += 1
        i += 1
      }
      else{
        i += 1
      }
    }

    return k
  }
}
