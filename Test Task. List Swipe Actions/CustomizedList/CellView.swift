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
    var width: CGFloat
    var buttonType: SwipeButtonType
    
    
    
    var body: some View {
        ZStack {
            BackgroundColor(buttonType: buttonType, size: width)
            
            SwipeButton(buttonType: buttonType, alignment: .left) { viewModel.buttonAction(of: buttonType, with: content) }

            SwipeButton(buttonType: buttonType, alignment: .right) { viewModel.buttonAction(of: buttonType, with: content) }

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
            .padding()
            .background(Color.white)
            .contentShape(Rectangle())
            .offset(x: content.offset)
            .gesture(viewModel.gestureAction(for: content, and: width, actionType: buttonType) )
            
        }
        .overlay(dividerLine)
    }
    
    var dividerLine: some View {
        VStack {
            Spacer()
            Divider()
        }
    }
}

struct CellView_Previews: PreviewProvider {
    static var previews: some View {
        CellView(content: CellModel(text: "1"), width: UIScreen.main.bounds.width, buttonType: .delete)
            .environmentObject(CustomizedListViewModel())
    }
}
