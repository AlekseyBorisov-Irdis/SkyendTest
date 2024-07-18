//
//  13_RomanToInteger.swift
//  IDKnowlegeDBTests
//
//  Created by Alexey on 18.07.2024.
//

/*
 Roman numerals are represented by seven different symbols: I, V, X, L, C, D and M.

 Symbol       Value
 I             1
 V             5
 X             10
 L             50
 C             100
 D             500
 M             1000

 For example, 2 is written as II in Roman numeral, just two ones added together. 12 is written as XII, which is simply X + II. The number 27 is written as XXVII, which is XX + V + II.

 Roman numerals are usually written largest to smallest from left to right. However, the numeral for four is not IIII. Instead, the number four is written as IV. Because the one is before the five we subtract it making four. The same principle applies to the number nine, which is written as IX. There are six instances where subtraction is used:

 I can be placed before V (5) and X (10) to make 4 and 9.
 X can be placed before L (50) and C (100) to make 40 and 90.
 C can be placed before D (500) and M (1000) to make 400 and 900.
 Given a roman numeral, convert it to an integer.

 Example 1:
 Input: s = "III"
 Output: 3
 Explanation: III = 3.

 Example 2:
 Input: s = "LVIII"
 Output: 58
 Explanation: L = 50, V= 5, III = 3.

 Example 3:
 Input: s = "MCMXCIV"
 Output: 1994
 Explanation: M = 1000, CM = 900, XC = 90 and IV = 4.


 Constraints:
 1 <= s.length <= 15
 s contains only the characters ('I', 'V', 'X', 'L', 'C', 'D', 'M').
 It is guaranteed that s is a valid roman numeral in the range [1, 3999].
*/

import XCTest

final class RomanToInteger: LeetcodeTask {
  struct TestCase {
    let data: String
    let result: Int
  }

  var testCases: [TestCase]!

  override func setUpWithError() throws {
    try super.setUpWithError()
    testCases = [
      TestCase(
        data: "III",
        result: 3
      ),
      TestCase(
        data: "LVIII",
        result: 58
      ),
      TestCase(
        data: "MCMXCIV",
        result: 1994
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

  private func mySolution(data:  String) -> Int {
    let romanNumbers: [Character: Int] = ["I": 1, "V": 5, "X": 10, "L": 50, "C": 100, "D": 500, "M": 1000]
    var previous: Character = Character(" ")
    var result = 0
    for character in data {
      guard let currentNumber = romanNumbers[character] else {
        continue
      }

      if let previousNumber = romanNumbers[previous],
         previousNumber < currentNumber {
        result += currentNumber - (previousNumber * 2)
      } else {
        result += currentNumber
      }

      previous = character
    }

    return result
  }

  private func bestTimeSolution(data:  String) -> Int {
    func romanToIntLetter(_ ch: Character) -> Int {
      if ch == "I"{ return 1 }
      else if ch == "V"{ return 5 }
      else if ch == "X"{ return 10 }
      else if ch == "L"{ return 50 }
      else if ch == "C"{ return 100 }
      else if ch == "D"{ return 500 }
      else if ch == "M"{ return 1000 }
      else { return -1 }
    }

    var result = 0;

    let chars = Array(data)

    for i in 0..<chars.count {
      if i<chars.count-1 && romanToIntLetter(chars[i]) < romanToIntLetter(chars[i+1]) {
        result -= romanToIntLetter(chars[i])
      } else{
        result += romanToIntLetter(chars[i])
      }
    }

    return result
  }

  private func bestMemorySolution(data:  String) -> Int {
    func weightOfCharactor(c: Character) -> Int{
      switch c {
        case "I":
          return 1
        case "V":
          return 5
        case "X":
          return 10
        case "L":
          return 50
        case "C":
          return 100
        case "D":
          return 500
        case "M":
          return 1000
        default:
          return 0
      }
    }

    var rs = 0
    var i = 0
    while i < data.count {
      let char = data[data.index(data.startIndex, offsetBy: i)]
      let w_char = weightOfCharactor(c: char)
      if i != data.count - 1 {
        let next_char = data[data.index(data.startIndex, offsetBy: i + 1)]
        let w_next_char = weightOfCharactor(c: next_char)
        if w_char < w_next_char {
          rs = rs + (w_next_char - w_char)
          i += 2
        } else {
          rs += w_char
          i += 1
        }
      } else {
        rs += w_char
        i += 1
      }
    }

    return rs
  }
}
