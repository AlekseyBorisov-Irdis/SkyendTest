//
//  DDProtocols.swift
//  IDKnowlegeDBTests
//
//  Created by Alexey on 12.07.2024.
//

import Foundation

protocol DDWihtouDefaultMethod {
  func method1()
}

extension DDWihtouDefaultMethod {
  func method2() {
    print("protocol extension")
  }
}

protocol DDWihtDefaultMethod {
  func method1()
  func method2()
}

extension DDWihtDefaultMethod {
  func method2() {
    print("protocol extension")
  }
}
