//
//  DDClasses.swift
//  IDKnowlegeDBTests
//
//  Created by Alexey on 12.07.2024.
//

import Foundation

final class DDFinalClass {
  func method1 () {
    print("direct dispatch")
  }
}

class DDWitoutProtocolMethod: DDWihtouDefaultMethod {
  func method1() {
    print("superclass")
  }
}

class DDWitoutProtocolMethodChild: DDWitoutProtocolMethod {
  override func method1() {
    print("child")
  }
}
