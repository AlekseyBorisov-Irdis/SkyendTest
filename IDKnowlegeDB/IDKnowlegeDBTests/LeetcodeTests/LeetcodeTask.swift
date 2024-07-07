//
//  LeetcodeTask.swift
//  IDKnowlegeDBTests
//
//  Created by Alexey on 05.07.2024.
//

import XCTest

class LeetcodeTask: XCTestCase {
  var metrics: [XCTMetric]!
  var measureOptions: XCTMeasureOptions!

  override func setUpWithError() throws {
    try super.setUpWithError()
    metrics = [
      XCTClockMetric(),
      XCTMemoryMetric()
    ]
    measureOptions = XCTMeasureOptions.default
    measureOptions.iterationCount = 10
  }

  override func tearDownWithError() throws {
    metrics = nil
    measureOptions = nil
    try super.tearDownWithError()
  }


  func customMeasure(_ block: () -> Void) {
    measure(
      metrics: metrics,
      options: measureOptions,
      block: block
    )
  }
}
