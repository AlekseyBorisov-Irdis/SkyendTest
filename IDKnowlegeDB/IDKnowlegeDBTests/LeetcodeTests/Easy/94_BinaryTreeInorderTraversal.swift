//
//  BinaryTreeInorderTraversal.swift
//  IDKnowlegeDBTests
//
//  Created by Alexey on 16.11.2024.
//

/*
 Given the root of a binary tree, return the inorder traversal of its nodes' values.

 Example 1:
 Input: root = [1,null,2,3]
 Output: [1,3,2]
 Explanation:
    1
     \
      2
     /
    3

 Example 2:
 Input: root = [1,2,3,4,5,null,8,null,null,6,7,9]
 Output: [4,2,6,5,7,1,3,9,8]
 Explanation:
           1
         /   \
        2     3
       / \     \
      4   5     8
         / \   /
        6   7 9

 Example 3:
 Input: root = []
 Output: []

 Example 4:
 Input: root = [1]
 Output: [1]

 Constraints:
 The number of nodes in the tree is in the range [0, 100].
 -100 <= Node.val <= 100

 Follow up: Recursive solution is trivial, could you do it iteratively?
 */

import XCTest

final class BinaryTreeInorderTraversal: LeetcodeTask {
  struct TestCase {
    let input: TreeNode?
    let expected: [Int]
  }

  private var testCases: [TestCase]!

  override func setUpWithError() throws {
    try super.setUpWithError()
    testCases = [
      TestCase(
        input: TreeNode(2, TreeNode(3, TreeNode(1), nil), nil),
        expected: [1,3,2]
      ),
      TestCase(
        input: TreeNode(1, nil, TreeNode(2, TreeNode(3), nil)),
        expected: [1,3,2]
      ),
      TestCase(
        input: TreeNode(1, nil, TreeNode(2, nil, TreeNode(3))),
        expected: [1,2,3]
      ),
      TestCase(
        input: TreeNode(
          1,
          TreeNode(
            2,
            TreeNode(4),
            TreeNode(
              5,
              TreeNode(6),
              TreeNode(7)
            )
          ),
          TreeNode(
            3,
            nil,
            TreeNode(
              8,
              TreeNode(9),
              nil
            )
          )
        ),
        expected: [4,2,6,5,7,1,3,9,8]
      ),
      TestCase(input: nil, expected: []),
      TestCase(input: TreeNode(1), expected: [1])
    ]
  }

  override func tearDownWithError() throws {
    testCases = nil
    try super.tearDownWithError()
  }

  func testMySolution() throws {
    for testCase in testCases {
      let result = mySolution(testCase.input)
      XCTAssertEqual(result, testCase.expected)
    }
  }

  func testMeasureMySolution() throws {
    customMeasure {
      for testCase in testCases {
        _ = mySolution(testCase.input)
      }
    }
  }

  private func mySolution(_ root: TreeNode?) -> [Int] {
    var result = [Int]()
    var stack = [TreeNode]()
    var currentNode = root

    while !stack.isEmpty || currentNode != nil {
      while currentNode != nil {
        stack.append(currentNode!)
        currentNode = currentNode?.left
      }

      currentNode = stack.popLast()
      result.append(currentNode!.val)
      currentNode = currentNode?.right
    }

    return result
  }
}
