//
//  DynamicDispatch.swift
//  IDKnowlegeDBTests
//
//  Created by Alexey on 07.07.2024.
//

import XCTest

final class DynamicDispatch: XCTestCase {
  override func setUpWithError() throws {}
  override func tearDownWithError() throws {}

  func testDispatch1() throws {
    func callFunc(_ object: DDProtocol) -> String {
      object.callMe()
    }

    let instance = DDB()

    XCTAssertEqual(instance.callMe(), "class")
    XCTAssertEqual(callFunc(instance), "protocol")
  }

  func testInherritance() throws {
    XCTAssertEqual(DDC().callMe(), "superclass")
    XCTAssertEqual(DDD().callMe(), "subclass")
    XCTAssertEqual((DDD() as DDC).callMe(), "subclass")
  }

  func testInherritanceEmptySuperclass() throws {
    XCTAssertEqual(DDE().callMe(), "protocol")
    XCTAssertEqual(DDF().callMe(), "subclass")
    XCTAssertEqual((DDF() as DDE).callMe(), "protocol")
  }
}
