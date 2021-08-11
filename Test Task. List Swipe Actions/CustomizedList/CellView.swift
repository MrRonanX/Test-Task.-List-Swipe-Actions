//
//  CellView.swift
//  Test Task. List Swipe Actions
//
//  Created by Roman Kavinskyi on 8/1/21.
//

import SwiftUI

struct CellView: View {
    @EnvironmentObject var viewModel: CustomizedListViewModel
    
    var content: CellModel
    var size: CGSize
    var secondaryButtonType: SwipeButtonType
    var primaryButtonType: SwipeButtonType
    var secondaryAction: () -> Void
    var primaryAction: () -> Void
    
    var body: some View {
        ZStack {
            BackgroundColor(buttonType: primaryButtonType, size: size.width)
            
            SecondaryButton(buttonType: secondaryButtonType, buttonAction: secondaryAction)
                .opacity(content.offset <= -90  ? 0 : 1 )
            
            SwipeButton(buttonType: primaryButtonType, alignment: .right, action: primaryAction)
            
            HStack {
                Text(content.text)
                Spacer()
                if content.isPinned {
                    Image(systemName: "pin.fill")
                        .foregroundColor(.yellow)
                        .padding(.trailing)
                }
                if content.isMarked {
                    Image(systemName: "checkmark")
                        .foregroundColor(.green)
                        .padding(.trailing)
                }
            }
            .padding(11.85)
            .padding(.leading, 8)
            .background(Color.white)
            .offset(x: content.offset)
            .gesture(viewModel.gestureAction(for: content, and: size.width) )
        }
        .overlay(dividerLine)
    }
    
    
    var dividerLine: some View {
        VStack {
            Spacer()
            Divider()
        }
        .padding(.leading, 16)
        .padding(.bottom, 0.4)
    }
}

struct CellView_Previews: PreviewProvider {
    static var previews: some View {
        CellView(content: CellModel(text: "1"),
                 size: UIScreen.main.bounds.size,
                 secondaryButtonType: .pin,
                 primaryButtonType: .delete,
                 secondaryAction: { print("Secondary Action")},
                 primaryAction: { print("Secondary Action")})
            .environmentObject(CustomizedListViewModel())
    }
}


