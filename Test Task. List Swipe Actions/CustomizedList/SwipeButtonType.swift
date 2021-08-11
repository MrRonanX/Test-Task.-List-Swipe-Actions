//
//  SwipeButtonType.swift
//  Test Task. List Swipe Actions
//
//  Created by Roman Kavinskyi on 8/11/21.
//

import SwiftUI

enum SwipeButtonType {
    case delete, pin, mark
}

extension SwipeButtonType {
    
    var backgroundColor: Color {
        switch self {
        case .delete:
            return Color.red
        case .pin:
            return Color.yellow
        case .mark:
            return Color.green
        }
    }
}
