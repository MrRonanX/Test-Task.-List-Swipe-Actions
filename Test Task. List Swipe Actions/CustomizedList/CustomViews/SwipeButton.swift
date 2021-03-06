//
//  SwipeButton.swift
//  Test Task. List Swipe Actions
//
//  Created by Roman Kavinskyi on 8/1/21.
//

import SwiftUI

enum ButtonAlignment {
    case left, right
}

struct SwipeButton: View {
    
    var buttonType: SwipeButtonType
    var alignment: ButtonAlignment
    var action: (() -> Void)? = nil
    
    var body: some View {
        HStack {
            if alignment == .right {
                Spacer()
                swipeButton
            } else {
                swipeButton
                Spacer()
            }
        }
    }
    
    
    func buttonAction() {
        action?()
    }
    
    
    var swipeButton: some View {
        Button(action: buttonAction) {
            Image(systemName: image)
                .font(.title2)
                .foregroundColor(.white)
        }
        .frame(width: 90)
        .contentShape(Rectangle())
    }
    
    
    var image: String {
        switch buttonType {
        case .delete:
            return "trash.fill"
        case .pin:
            return "pin.fill"
        case .mark:
            return "checkmark.circle"
        }
    }
}

struct SwipeButton_Previews: PreviewProvider {
    static var previews: some View {
        SwipeButton(buttonType: .delete, alignment: .right)
    }
}
