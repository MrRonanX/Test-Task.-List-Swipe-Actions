//
//  CellModel.swift
//  Test Task. List Swipe Actions
//
//  Created by Roman Kavinskyi on 8/1/21.
//

import SwiftUI

enum CurrentPosition {
    case initial, leftThresholdReached, rightThresholdReached
}

struct CellModel: Identifiable {
    let id = UUID()
    let text: String
    var offset: CGFloat = 0
    var cellPosition: CurrentPosition = .initial
    var reachedThreshold = false
    var isPinned = false
    var isMarked = false
    var sortingNumber = 0
    let buttonNumber = Int.random(in: 0...2)
}
