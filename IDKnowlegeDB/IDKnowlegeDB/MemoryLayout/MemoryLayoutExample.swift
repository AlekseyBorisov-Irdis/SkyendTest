//
//  MemoryLayoutExample.swift
//  IDKnowlegeDB
//
//  Created by Alexey on 29.06.2024.
//

import Foundation

private struct MemoryLayoutStruct1Example {
  let boolFlag = false
  let stringValue = "Hello, world!"
}

private struct MemoryLayoutStruct2Example {
  let stringValue = "Hello, world!"
  let boolFlag = false
}

final class MemoryLayoutExample {
  init() {}

  func compareStructures() {
    printLayout(of: MemoryLayoutStruct1Example())
    printLayout(of: MemoryLayoutStruct2Example())
  }

  private func printLayout<T>(of object: T) {
    print("""
    Memory layout of \(object.self):
    size: \(MemoryLayout<T>.size)
    stride: \(MemoryLayout<T>.stride)
    alignment: \(MemoryLayout<T>.alignment)
    """)
  }
}
