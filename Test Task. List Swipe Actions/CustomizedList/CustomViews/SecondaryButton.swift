//
//  SecondaryButton.swift
//  Test Task. List Swipe Actions
//
//  Created by Roman Kavinskyi on 8/11/21.
//

import SwiftUI

struct SecondaryButton: View {
    
    var buttonType: SwipeButtonType
    var buttonAction: () -> Void
    
    var body: some View {
        ZStack {
            HStack {
                BackgroundColor(buttonType: buttonType, size: 90)
                Spacer()
            }
            SwipeButton(buttonType: buttonType, alignment: .left, action: buttonAction)
        }
    }
}

struct SecondaryButton_Previews: PreviewProvider {
    static var previews: some View {
        SecondaryButton(buttonType: .pin, buttonAction: { print("Secondary Button Action") })
    }
}
