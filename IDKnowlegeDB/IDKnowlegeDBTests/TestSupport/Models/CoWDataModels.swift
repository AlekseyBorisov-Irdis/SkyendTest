//
//  CoWDataModels.swift
//  IDKnowlegeDBTests
//
//  Created by Alexey on 07.07.2024.
//

import Foundation

class CoW_ContactClass: NSCopying {
  var name = "none"
  
  init(name: String) {
    self.name = name
  }

  func copy(with zone: NSZone? = nil) -> Any {
    let copiedObj = CoW_ContactClass(name: name)
    return copiedObj
  }
}

struct CoW_ContactStructure {
  var name = "none"
}

final class Ref<T> {
  var val: T
  init(_ val: T) { self.val = val }
}

struct Box<T> {
  var ref: Ref<T>
  init(_ x: T) { ref = Ref(x) }

  var value: T {
    get { ref.val }
    set {
      if isKnownUniquelyReferenced(&ref) {
        ref = Ref(newValue)
        return
      }
      ref.val = newValue
    }
  }
}
