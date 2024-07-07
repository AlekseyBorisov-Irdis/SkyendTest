//
//  MemoryAddress.swift
//  IDKnowlegeDBTests
//
//  Created by Alexey on 07.07.2024.
//

import Foundation

enum MemoryAddress<T> {
  static func address(of classInstance: T) -> String  where T: AnyObject {
    let value = unsafeBitCast(classInstance, to: Int.self)
    return toString(value)
  }

  static func address(of valueType: UnsafePointer<T>) -> String {
    let value = Int(bitPattern: valueType)
    return toString(value)
  }

  private static func toString(_ value: Int) -> String {
    let lengt = 2 + 2 * MemoryLayout<UnsafeRawPointer>.size
    return String(format: "%0\(lengt)p", value)
  }
}
