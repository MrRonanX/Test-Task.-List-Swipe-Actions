//
//  SwipeButton.swift
//  Test Task. List Swipe Actions
//
//  Created by Roman Kavinskyi on 8/1/21.
//

import SwiftUI

enum SwipeButtonType: CaseIterable {
    case delete, pin, mark
    
}

struct SwipeButton: View {
    
    var buttonType: SwipeButtonType
    var action: (() -> Void)? = nil
   
    var body: some View {
        Group {
            Spacer()
            Button { action?() }
                label: {
                    Image(systemName: image)
                        .font(.title)
                        .foregroundColor(.white)
                }
                .frame(width: 90)
        }
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
        SwipeButton(buttonType: .delete)
    }
}
