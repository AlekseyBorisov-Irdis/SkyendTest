//
//  MergeSortedArray.swift
//  IDKnowlegeDBTests
//
//  Created by Alexey on 11.11.2024.
//

/*
 You are given two integer arrays nums1 and nums2, sorted in non-decreasing order, and two integers m and n, representing the number of elements in nums1 and nums2 respectively.

 Merge nums1 and nums2 into a single array sorted in non-decreasing order.

 The final sorted array should not be returned by the function, but instead be stored inside the array nums1. To accommodate this, nums1 has a length of m + n, where the first m elements denote the elements that should be merged, and the last n elements are set to 0 and should be ignored. nums2 has a length of n.

 Example 1:
 Input: nums1 = [1,2,3,0,0,0], m = 3, nums2 = [2,5,6], n = 3
 Output: [1,2,2,3,5,6]
 Explanation: The arrays we are merging are [1,2,3] and [2,5,6].
 The result of the merge is [1,2,2,3,5,6] with the underlined elements coming from nums1.

 Example 2:
 Input: nums1 = [1], m = 1, nums2 = [], n = 0
 Output: [1]
 Explanation: The arrays we are merging are [1] and [].
 The result of the merge is [1].

 Example 3:
 Input: nums1 = [0], m = 0, nums2 = [1], n = 1
 Output: [1]
 Explanation: The arrays we are merging are [] and [1].
 The result of the merge is [1].
 Note that because m = 0, there are no elements in nums1. The 0 is only there to ensure the merge result can fit in nums1.

 Constraints:
 nums1.length == m + n
 nums2.length == n
 0 <= m, n <= 200
 1 <= m + n <= 200
 -109 <= nums1[i], nums2[j] <= 109

 Follow up: Can you come up with an algorithm that runs in O(m + n) time?
 */

import XCTest

final class MergeSortedArray: LeetcodeTask {
  struct TestCase {
    let nums1: [Int]
    let m: Int
    let nums2: [Int]
    let n: Int
    let expected: [Int]
  }

  private var testCases: [TestCase]!

  override func setUpWithError() throws {
    try super.setUpWithError()
    testCases = [
      TestCase(
        nums1: [1, 2, 3, 0, 0, 0],
        m: 3,
        nums2: [2, 5, 6],
        n: 3,
        expected: [1, 2, 2, 3, 5, 6]
      ),
      TestCase(nums1: [1], m: 1, nums2: [], n: 0, expected: [1]),
      TestCase(nums1: [0], m: 0, nums2: [1], n: 1, expected: [1]),
      TestCase(
        nums1: [-3, -1, 0, 1, 3, 0, 0, 0],
        m: 5,
        nums2: [-2, 0, 2],
        n: 3,
        expected: [-3, -2, -1, 0, 0, 1, 2, 3]
      ),
      TestCase(
        nums1: [4, 5, 6, 0, 0, 0],
        m: 3,
        nums2: [1, 2, 3],
        n: 3,
        expected: [1, 2, 3, 4, 5, 6]
      ),
      TestCase(
        nums1: [4, 0, 0, 0],
        m: 1,
        nums2: [1, 2, 3],
        n: 3,
        expected: [1, 2, 3, 4]
      )
    ]
  }

  override func tearDownWithError() throws {
    testCases = nil
    try super.tearDownWithError()
  }

  func testMySolution() throws {
    for testCase in testCases {
      var nums1 = testCase.nums1
      mySolution(&nums1, testCase.m, testCase.nums2, testCase.n)
      XCTAssertEqual(nums1, testCase.expected)
    }
  }

  func testMeasureMySolution() throws {
    customMeasure {
      for testCase in testCases {
        var nums1 = testCase.nums1
        mySolution(&nums1, testCase.m, testCase.nums2, testCase.n)
      }
    }
  }

  func testBestTimeSolution() throws {
    for testCase in testCases {
      var nums1 = testCase.nums1
      bestTimeSolution(&nums1, testCase.m, testCase.nums2, testCase.n)
      XCTAssertEqual(nums1, testCase.expected)
    }
  }

  func testMeasureBestTimeSolution() throws {
    customMeasure {
      for testCase in testCases {
        var nums1 = testCase.nums1
        bestTimeSolution(&nums1, testCase.m, testCase.nums2, testCase.n)
      }
    }
  }

  func testBestMemorySolution() throws {
    for testCase in testCases {
      var nums1 = testCase.nums1
      bestMemorySolution(&nums1, testCase.m, testCase.nums2, testCase.n)
      XCTAssertEqual(nums1, testCase.expected)
    }
  }

  func testMeasureBestMemorySolution() throws {
    customMeasure {
      for testCase in testCases {
        var nums1 = testCase.nums1
        bestMemorySolution(&nums1, testCase.m, testCase.nums2, testCase.n)
      }
    }
  }

  private func mySolution(
    _ nums1: inout [Int],
    _ m: Int,
    _ nums2: [Int],
    _ n: Int
  ) {
    guard n > 0 else { return }
    if m == 0 {
      nums1 = nums2
      return
    }
    var index1 = 0, index2 = 0
    var result = [Int]()
    while index1 < m || index2 < n {
      var val1: Int?, val2: Int?
      if index1 < m {
        val1 = nums1[index1]
      }
      if index2 < n {
        val2 = nums2[index2]
      }

      if let val1, let val2 {
        if val1 < val2 {
          result.append(val1)
          index1 += 1
        } else {
          result.append(val2)
          index2 += 1
        }
      } else if let val1 {
        result.append(val1)
        index1 += 1
      } else if let val2 {
        result.append(val2)
        index2 += 1
      }
    }
    nums1 = result
  }

  private func bestTimeSolution(
    _ nums1: inout [Int],
    _ m: Int,
    _ nums2: [Int],
    _ n: Int
  ) {
    var prefixM = nums1.prefix(m)
    nums1 = Array(prefixM)

    let result = (nums1 + nums2).sorted { $0 < $1 }
    nums1 = result
  }

  private func bestMemorySolution(
    _ nums1: inout [Int],
    _ m: Int,
    _ nums2: [Int],
    _ n: Int
  ) {
    var i = m-1, j = n - 1, k = nums1.count - 1

    while j >= 0 {
      if i < 0 {
        nums1[k] = nums2[j]
        j -= 1
        k -= 1
      } else if nums2[j] >= nums1[i] {
        nums1[k] = nums2[j]
        j-=1
        k-=1
      } else {
        nums1[k] = nums1[i]
        i -= 1
        k -= 1
      }
    }
  }
}
