//
//  DynamicDispatchModels.swift
//  IDKnowlegeDBTests
//
//  Created by Alexey on 07.07.2024.
//

import Foundation

protocol DDProtocol {
  func callMe() -> String
}

extension DDProtocol {
  func callMe() -> String { "protocol" }
}

class DDA: DDProtocol {}
class DDB: DDA {
  func callMe() -> String { "class" }
}

class DDC: DDProtocol {
  func callMe() -> String { "superclass" }
}

class DDD: DDC {
  override func callMe() -> String { "subclass" }
}

class DDE: DDProtocol {}

class DDF: DDE {
  func callMe() -> String { "subclass" }
}
