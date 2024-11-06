//
//  67_AddBinary.swift
//  IDKnowlegeDB
//
//  Created by Alexey on 05.11.2024.
//

/*
 Given two binary strings a and b, return their sum as a binary string.

 Example 1:
 Input: a = "11", b = "1"
 Output: "100"

 Example 2:
 Input: a = "1010", b = "1011"
 Output: "10101"

 Example 3:
 Input:
 a = "10100000100100110110010000010101111011011001101110111111111101000000101111001110001111100001101"
 b = "110101001011101110001111100110001010100001101011101010000011011011001011101111001100000011011110011"
 Output:
 "110111101100010011000101110110100000011101000101011001000011011000001100011110011010010011000000000"

 Constraints:
 1 <= a.length, b.length <= 104
 a and b consist only of '0' or '1' characters.
 Each string does not contain leading zeros except for the zero itself.
 */

import XCTest

final class AddBinaryTests: LeetcodeTask {
  struct TestCase {
    let input: (a: String, b: String)
    let expected: String
  }

  var testCases: [TestCase]!

  override func setUpWithError() throws {
    try super.setUpWithError()

    testCases = [
      TestCase(
        input: ("11", "1"),
        expected: "100"
      ),
      TestCase(
        input: ("1010", "1011"),
        expected: "10101"
      ),
      TestCase(
        input: (
          "10100000100100110110010000010101111011011001101110111111111101000000101111001110001111100001101",
          "110101001011101110001111100110001010100001101011101010000011011011001011101111001100000011011110011"
        ),
        expected: "110111101100010011000101110110100000011101000101011001000011011000001100011110011010010011000000000"
      )
    ]
  }

  override func tearDownWithError() throws {
    testCases = nil
    try super.tearDownWithError()
  }

  func testMySolution1() {
    testCases.forEach { testCase in
      XCTAssertEqual(
        mySolution1(
          testCase.input.a,
          testCase.input.b
        ),
        testCase.expected
      )
    }
  }

  func testMeasureMySolution1() {
    customMeasure {
      _ = testCases.map { mySolution1($0.input.a, $0.input.b) }
    }
  }

  func testBestTimeSolution() {
    testCases.forEach { testCase in
      XCTAssertEqual(
        bestTimeSolution(
          testCase.input.a,
          testCase.input.b
        ),
        testCase.expected
      )
    }
  }

  func testMeasureBestTimeSolution() {
    customMeasure {
      _ = testCases.map { bestTimeSolution($0.input.a, $0.input.b) }
    }
  }

  func testBestMemorySolution() {
    testCases.forEach { testCase in
      XCTAssertEqual(
        bestMemorySolution(
          testCase.input.a,
          testCase.input.b
        ),
        testCase.expected
      )
    }
  }

  func testMeasureBestMemorySolution() {
    customMeasure {
      _ = testCases.map { bestMemorySolution($0.input.a, $0.input.b) }
    }
  }

  // По идее, тут не нужны проверки, так как у нас есть констрейнты, которые говорят, что пустыми строки быть не могут.
  // Работаем кустарно со строками
  private func mySolution1(_ a: String, _ b: String) -> String {
    var result: String = ""
    var number1 = a
    var number2 = b

    var nextRegister = 0
    while !number1.isEmpty || !number2.isEmpty {
      var registerSum = nextRegister
      if !number1.isEmpty {
        registerSum += Int(String(number1.removeLast())) ?? 0
      }
      if !number2.isEmpty {
        registerSum += Int(String(number2.removeLast())) ?? 0
      }
      if registerSum > 1 {
        result.insert(String(registerSum-2).first ?? "0", at: result.startIndex)
        nextRegister = 1
      } else {
        result.insert(String(registerSum).first ?? "0", at: result.startIndex)
        nextRegister = 0
      }
    }
    if nextRegister > 0 {
      result.insert("1", at: result.startIndex)
    }
    return result
  }

  private func bestTimeSolution(_ a: String, _ b: String) -> String {
    var num1:[Character]!
    var num2:[Character]!

    if a.count >= b.count {
      num1 = Array(a)
      num2 = Array(b)
    } else {
      num1 = Array(b)
      num2 = Array(a)
    }

    var rem = 0
    var i = 0

    var reversedResult = [Character]()
    reversedResult.reserveCapacity(num1.count + 1)

    while i <  num1.count  {
      let num1I = num1.count - 1 - i
      let num2I = num2.count - 1 - i
      let sum =  num1[num1I].wholeNumberValue! + rem + ((num2I >= 0) ? num2[num2I].wholeNumberValue! : 0)
      switch sum {
        case 0:
          reversedResult.append("0")
        case 1:
          reversedResult.append("1")
          rem = 0
        case 2:
          reversedResult.append("0")
          rem = 1
        case 3:
          reversedResult.append("1")
          rem = 1
        default:
          break
      }
      i += 1
    }

    if rem == 1 {
      reversedResult.append("1")
    }
    reversedResult.reverse()
    let str:String = String(reversedResult)
    return str
  }

  private func bestMemorySolution(_ a: String, _ b: String) -> String {
    var result = ""
    var carry = 0

    let aChars = Array(a.reversed())
    let bChars = Array(b.reversed())

    let maxLength = max(aChars.count, bChars.count)

    for i in 0..<maxLength {
      let digitA = i < aChars.count ? Int(String(aChars[i]))! : 0
      let digitB = i < bChars.count ? Int(String(bChars[i]))! : 0

      let sum = digitA + digitB + carry
      result = String(sum % 2) + result
      carry = sum / 2
    }

    if carry > 0 {
      result = "1" + result
    }

    return result
  }
}
