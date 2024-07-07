//
//  Array+TestUtils.swift
//  IDKnowlegeDBTests
//
//  Created by Alexey on 07.07.2024.
//

import Foundation

extension Array where Element: NSCopying {
  public var copy: [Element] {
    map { $0.copy() as! Element }
  }
}
