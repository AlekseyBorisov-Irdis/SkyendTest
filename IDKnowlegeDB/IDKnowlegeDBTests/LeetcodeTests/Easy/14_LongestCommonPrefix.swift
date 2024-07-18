//
//  14_LongestCommonPrefix.swift
//  IDKnowlegeDBTests
//
//  Created by Alexey on 18.07.2024.
//

/*
 Write a function to find the longest common prefix string amongst an array of strings.
 If there is no common prefix, return an empty string "".

 Example 1:
 Input: strs = ["flower","flow","flight"]
 Output: "fl"

 Example 2:
 Input: strs = ["dog","racecar","car"]
 Output: ""
 Explanation: There is no common prefix among the input strings.

 Constraints:
 1 <= strs.length <= 200
 0 <= strs[i].length <= 200
 strs[i] consists of only lowercase English letters.
*/

import XCTest

final class _4_LongestCommonPrefix: LeetcodeTask {
  struct TestCase {
    let data: [String]
    let result: String
  }

  var testCases: [TestCase]!

  override func setUpWithError() throws {
    try super.setUpWithError()
    testCases = [
      TestCase(
        data: ["flower","flow","flight"],
        result: "fl"
      ),
      TestCase(
        data: ["dog","racecar","car"],
        result: ""
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

  private func mySolution(data:  [String]) -> String {
    guard let firstWord = data.first else { return "" }
    var prefix = firstWord

    while data.filter({ $0.hasPrefix(prefix) }).count != data.count && !prefix.isEmpty {
        prefix.removeLast()
    }

    return prefix
  }

  private func bestTimeSolution(data:  [String]) -> String {
    guard let firstWord = data.first else { return "" }
    var prefix = firstWord

    while data.filter({ $0.hasPrefix(prefix) }).count != data.count && !prefix.isEmpty {
      prefix.removeLast()
    }

    return prefix
  }

  private func bestMemorySolution(data:  [String]) -> String {
    var mutable = data
    var longest = mutable.removeFirst()

    mutable.forEach {
      longest = $0.commonPrefix(with: longest)
    }

    return longest
  }
}
