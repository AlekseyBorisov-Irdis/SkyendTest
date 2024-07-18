//
//  LinkedList.swift
//  IDKnowlegeDBTests
//
//  Created by Alexey on 12.07.2024.
//

import XCTest

final class LinkedList: XCTestCase {
  private var listInt: IDLinkedList<Int>!

  override func setUpWithError() throws {
    try super.setUpWithError()
  }

  override func tearDownWithError() throws {
    listInt = nil
    try super.tearDownWithError()
  }

  func testAppend() throws {
    listInt = IDLinkedList()
    listInt.append(2)
    XCTAssertEqual(listInt.count, 1)
    XCTAssertEqual(listInt.head?.value, 2)
    XCTAssertEqual(listInt.tail?.value, 2)
    
    listInt.append(5)
    XCTAssertEqual(listInt.count, 2)
    XCTAssertEqual(listInt.head?.value, 2)
    XCTAssertEqual(listInt.tail?.value, 5)
  }

  func testPerformanceExample() throws {
    // This is an example of a performance test case.
    self.measure {
      // Put the code you want to measure the time of here.
    }
  }

}
