//
//  CopyOnWrite.swift
//  IDKnowlegeDBTests
//
//  Created by Alexey on 07.07.2024.
//

import XCTest

final class CopyOnWrite: XCTestCase {
  override func setUpWithError() throws {}

  override func tearDownWithError() throws {}

  func testCoWArrayChange() throws {
    var arrayA = [1,2,3]
    var arrayB = arrayA
    
    var addrA = MemoryAddress.address(of: &arrayA)
    let addrB = MemoryAddress.address(of: &arrayB)
    XCTAssertEqual(addrA, addrB)

    arrayA.append(4)
    addrA = MemoryAddress.address(of: &arrayA)
    XCTAssertNotEqual(addrA, addrB)
  }

  func testSurfaceCopyingWithClass() throws {
    var arrayA = [CoW_ContactClass(name: "Ivan")]

    // Surface copying
    var arrayB = arrayA

    XCTAssertEqual(
      MemoryAddress.address(of: &arrayA),
      MemoryAddress.address(of: &arrayB)
    )

    arrayB[0].name = "Petr"
    
    XCTAssertEqual(
      MemoryAddress.address(of: &arrayA),
      MemoryAddress.address(of: &arrayB)
    )
    XCTAssertEqual(arrayA[0].name, arrayB[0].name)
  }

  func testDeepCopyingWithClass() throws {
    var arrayA = [CoW_ContactClass(name: "Ivan")]

    // Surface copying
    var arrayB = arrayA.copy

    XCTAssertNotEqual(
      MemoryAddress.address(of: &arrayA),
      MemoryAddress.address(of: &arrayB)
    )

    arrayB[0].name = "Petr"

    XCTAssertNotEqual(
      MemoryAddress.address(of: &arrayA),
      MemoryAddress.address(of: &arrayB)
    )
    XCTAssertNotEqual(arrayA[0].name, arrayB[0].name)
  }

  func testStructureCopying() throws {
    var contactA = CoW_ContactStructure()
    var contactB = contactA
    XCTAssertNotEqual(
      MemoryAddress.address(of: &contactA),
      MemoryAddress.address(of: &contactB)
    )
  }

  func testCopyingArraysWithStructures() throws {
    var arrayA = [CoW_ContactStructure(name: "Ivan")]
    var arrayB = arrayA

    XCTAssertEqual(
      MemoryAddress.address(of: &arrayA),
      MemoryAddress.address(of: &arrayB)
    )

    arrayB[0].name = "Petr"

    XCTAssertNotEqual(
      MemoryAddress.address(of: &arrayA),
      MemoryAddress.address(of: &arrayB)
    )
  }

  func testCoWOnCustomStructure() throws {
    var contact = CoW_ContactStructure(name: "Ivan")
    var boxA = Box(contact)
    var boxB = boxA
    
    XCTAssertEqual(
      MemoryAddress.address(of: &boxA.value),
      MemoryAddress.address(of: &boxB.value)
    )

    boxB.value.name = "Petr"

    XCTAssertEqual(
      MemoryAddress.address(of: &boxA.value),
      MemoryAddress.address(of: &boxB.value)
    )
  }
}
