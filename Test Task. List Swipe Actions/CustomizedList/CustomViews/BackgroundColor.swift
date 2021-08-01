//
//  BackgroundColor.swift
//  Test Task. List Swipe Actions
//
//  Created by Roman Kavinskyi on 8/1/21.
//

import SwiftUI

struct BackgroundColor: View {

    var buttonType: SwipeButtonType
    var size: CGFloat
    var body: some View {
        backgroundColor
                .frame(width: size)
    }
    
    var backgroundColor: Color {
        switch buttonType {
        case .delete:
            return Color.red
        case .pin:
            return Color.yellow
        case .mark:
            return Color.green
        }
    }
}

struct BackgroundColor_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundColor(buttonType: .delete, size: UIScreen.main.bounds.width)
    }
}
