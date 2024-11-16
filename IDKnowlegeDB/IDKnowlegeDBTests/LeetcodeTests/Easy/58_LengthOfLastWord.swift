//
//  58_LengthOfLastWord.swift
//  IDKnowlegeDBTests
//
//  Created by Alexey on 18.07.2024.
//

/*
 Given a string s consisting of words and spaces, return the length of the last word in the string.
 A word is a maximal substring consisting of non-space characters only.

 Example 1:
 Input: s = "Hello World"
 Output: 5
 Explanation: The last word is "World" with length 5.

 Example 2:
 Input: s = "   fly me   to   the moon  "
 Output: 4
 Explanation: The last word is "moon" with length 4.

 Example 3:
 Input: s = "luffy is still joyboy"
 Output: 6
 Explanation: The last word is "joyboy" with length 6.

 Constraints:
 1 <= s.length <= 104
 s consists of only English letters and spaces ' '.
 There will be at least one word in s.
*/

import XCTest

final class LengthOfLastWord: LeetcodeTask {
  struct TestCase {
    let s: String
    let result: Int
  }

  private var testCases: [TestCase]!

  override func setUpWithError() throws {
    try super.setUpWithError()
    testCases = [
      TestCase(
        s: "Hello World",
        result: 5
      ),
      TestCase(
        s: "   fly me   to   the moon  ",
        result: 4
      ),
      TestCase(
        s: "luffy is still joyboy",
        result: 6
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
        mySolution(testCase.s),
        testCase.result
      )
    }
  }

  func testMySolution2() throws {
    for testCase in testCases {
      XCTAssertEqual(
        mySolution2(testCase.s),
        testCase.result
      )
    }
  }

  func testBestTimeSolution() throws {
    for testCase in testCases {
      XCTAssertEqual(
        bestTimeSolution(testCase.s),
        testCase.result
      )
    }
  }

  func testBestMemorySolution() throws {
    for testCase in testCases {
      XCTAssertEqual(
        bestMemorySolution(testCase.s),
        testCase.result
      )
    }
  }

  func testMeasureMySolution() throws {
    customMeasure {
      _ = testCases.map { mySolution($0.s) }
    }
  }

  func testMeasureMySolution2() throws {
    customMeasure {
      _ = testCases.map { mySolution2($0.s) }
    }
  }

  func testMeasureBestTimeSolution() throws {
    customMeasure {
      _ = testCases.map { bestTimeSolution($0.s) }
    }
  }

  func testMeasureBestMemorySolution() throws {
    customMeasure {
      _ = testCases.map { bestMemorySolution($0.s) }
    }
  }

  private func mySolution(_ s: String) -> Int {
    s.components(separatedBy: CharacterSet.whitespacesAndNewlines)
      .last(where: {$0.count > 0 })?
      .count ?? 0
  }

  private func mySolution2(_ s: String) -> Int {
    var offset = s.count - 1
    var count = 0
    while offset >= 0 {
      let char = s.index(s.startIndex, offsetBy: offset)
      if s[char].isLetter {
        count += 1
      } else {
        if count > 0 {
          return count
        }
      }
      offset -= 1
    }

    return count
  }

  private func bestTimeSolution(_ s: String) -> Int {
    s.split { $0 == " " }.last?.count ?? 0
  }

  private func bestMemorySolution(_ s: String) -> Int {
    var count = 0
    for i in s.reversed() {
      if i == " " && count != 0 {
        return count
      }
      if i != " " {
        count += 1
      }
    }
    return count
  }
}
