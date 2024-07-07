//
//  FirstOccurance.swift
//  IDKnowlegeDBTests
//
//  Created by Alexey on 05.07.2024.
//

/*
 Given two strings needle and haystack, return the index of the first occurrence of needle in haystack, or -1 if needle is not part of haystack.

 Example 1:
 Input: haystack = "sadbutsad", needle = "sad"
 Output: 0
 Explanation: "sad" occurs at index 0 and 6.
 The first occurrence is at index 0, so we return 0.

 Example 2:
 Input: haystack = "leetcode", needle = "leeto"
 Output: -1
 Explanation: "leeto" did not occur in "leetcode", so we return -1.
 */

import XCTest

final class FirstOccurance: LeetcodeTask {
  struct TestCase {
    let haystack: String
    let needle: String
    let expectedResult: Int
  }

  var testCases: [TestCase]!

  override func setUpWithError() throws {
    try super.setUpWithError()
    testCases = [
      TestCase(
        haystack: "sadbutsad",
        needle: "sad",
        expectedResult: 0
      ),
      TestCase(
        haystack: "leetcode",
        needle: "leeto",
        expectedResult: -1
      ),
      TestCase(
        haystack: "qwerewqrtiqeturepiutreqpitupqreiotuqpriutpqreiutiropequtiroequtiuqretireuqtiouqeproitureipqutpirequtipquerpitouqeiorturqeoutierutpiqeurtopiquertpuiqreptupqeriutpioequtioequtipoqeurtioqueritouqeripotupqoirutqopierutpqioruetopiquetpoiuqroputpqieorutoieqrutopqeirutoipueqrpoutioqeprutpoeriuqtpoqieurtpoiqueroptiuqreipotupqoeirutqpoeiurtqpioerutipoqeurtpoeqirutopqierutpqoieurtopqreiutpoqriuetpoiquertpoiuqretpoiureqpotiueqpriutqpeoirutpqeoriutpqeriutpoqreiutpreoqiutpqeirutpqerioutpeqroituqeporituepoqriutqpoeirtusad",
        needle: "sad",
        expectedResult: 510
      ),
    ]
  }
  override func tearDownWithError() throws {
    testCases = nil
    try super.tearDownWithError()
  }
  
  func testSolution() throws {
    for testCase in testCases {
      XCTAssertEqual(mySolution1(testCase.haystack, testCase.needle), testCase.expectedResult)
      XCTAssertEqual(mySolution2(testCase.haystack, testCase.needle), testCase.expectedResult)
      XCTAssertEqual(bestTimeSolution(testCase.haystack, testCase.needle), testCase.expectedResult)
      XCTAssertEqual(bestMemorySolution(testCase.haystack, testCase.needle), testCase.expectedResult)
    }
  }

  func testPerformanceMySolution1() throws {
    let testCase = testCases[2]
    customMeasure {
      _ = mySolution1(testCase.haystack, testCase.needle)
    }
  }

  func testPerformanceMySolution2() throws {
    let testCase = testCases[2]
    customMeasure {
      _ = mySolution2(testCase.haystack, testCase.needle)
    }
  }

  func testPerformanceBestTimeSolution() throws {
    let testCase = testCases[2]
    customMeasure {
      _ = bestTimeSolution(testCase.haystack, testCase.needle)
    }
  }

  func testPerformanceBestMemorySolution() throws {
    let testCase = testCases[2]
    customMeasure{
      _ = bestMemorySolution(testCase.haystack, testCase.needle)
    }
  }

  private func mySolution1(_ haystack: String, _ needle: String) -> Int {
    guard
      !haystack.isEmpty && !needle.isEmpty,
      needle.count <= haystack.count
    else { return -1 }

    if haystack.count == needle.count {
      return haystack == needle ? 0 : -1
    }

    guard let result = haystack.firstRange(of: needle) else {
      return -1
    }

    return haystack.distance(from: haystack.startIndex, to: result.lowerBound)
  }

  private func mySolution2(_ haystack: String, _ needle: String) -> Int {
    guard
      !haystack.isEmpty && !needle.isEmpty,
      needle.count < haystack.count
    else { return -1 }

    if haystack.count == needle.count {
      return haystack == needle ? 0 : -1
    }

    var pointer = 0
    while pointer < haystack.count - needle.count + 1 {
      let currentStartIndex = haystack.index(haystack.startIndex, offsetBy: pointer)
      if haystack[currentStartIndex] == needle[needle.startIndex] {
        if haystack[currentStartIndex..<haystack.index(haystack.startIndex, offsetBy: pointer + needle.count)] == needle {
          return pointer
        } else {
          pointer += needle.count
        }
      } else {
        pointer += 1
      }
    }

    return -1
  }

  private func bestTimeSolution(_ haystack: String, _ needle: String) -> Int {
    let subStr = Array(needle)
    let str = Array(haystack)
    var temp:[Int] = []
    var firstI:Int = -1
    var i:Int = 0
    var j:Int = 0
    var t:Int = 0
    if subStr.count < str.count{
      while i < str.count{
        if subStr[0] == str[i]{
          temp.append(i)
        }
        i += 1
      }
      if temp.isEmpty {
        return -1
      }
      while t < temp.count{
        i = temp[t]
        while i < str.count{
          if subStr[j] == str[i]{
            j += 1
            if j == subStr.count{
              firstI = i - (subStr.count-1)
              return firstI
            }
          } else {
            j = 0
            break
          }
          i += 1
        }
        t += 1
      }
    }
    if needle == haystack{
      firstI = 0
    }
    return firstI
  }

  private func bestMemorySolution(_ haystack: String, _ needle: String) -> Int {
    guard haystack.count >= needle.count else { return -1 }
    guard haystack != needle else { return 0 }
    guard needle.count > 1 else {
        if let index = haystack.firstIndex(of: Character(needle)) {
            return haystack.distance(from: haystack.startIndex, to: index)
        }
        return -1
    }

    let array = Array(haystack)
    let needleArray = Array(needle)

    for i in 0...(haystack.count - needle.count) {
        if Array(array[i..<i+needle.count]) == needleArray {
            return i
        }
    }

    return -1
  }
}
