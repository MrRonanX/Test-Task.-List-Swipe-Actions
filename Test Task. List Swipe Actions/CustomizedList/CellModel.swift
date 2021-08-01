//
//  CellModel.swift
//  Test Task. List Swipe Actions
//
//  Created by Roman Kavinskyi on 8/1/21.
//

import SwiftUI

struct CellModel: Identifiable {
    let id = UUID()
    let text: String
    var offset: CGFloat = 0
    var reachedThreshold = false
    var isPinned = false
    var isMarked = false
    var sortingNumber = 0
    let buttonNumber = Int.random(in: 0...2)
}
