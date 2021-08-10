//
//  CustomizedListViewMode.swift
//  Test Task. List Swipe Actions
//
//  Created by Roman Kavinskyi on 8/1/21.
//

import SwiftUI

final class CustomizedListViewModel: ObservableObject {
    @Published var data = (1...10).map { CellModel(text: String($0), sortingNumber: $0) }
    var allButtonTypes = SwipeButtonType.allCases
    
    
    func buttonAction(of buttonType: SwipeButtonType, with content: CellModel) {
        switch buttonType {
        case .delete:
            deleteText(of: content)
        case .pin:
            pinText(of: content)
        case .mark:
            markText(of: content)
        }
    }
    
    func deleteText(of cell: CellModel) {
        withAnimation {
            let index = getIndex(of: cell.text)
            data.remove(at: index)
        }
    }
    
    func markText(of cell: CellModel) {
        withAnimation {
            let index = getIndex(of: cell.text)
            data[index].isMarked = true
            data[index].offset = 0
        }
    }
    
    func pinText(of cell: CellModel) {
        withAnimation {
            let index = getIndex(of: cell.text)
            var localItem = data[index]
            localItem.isPinned.toggle()
            localItem.offset = 0
            data.remove(at: index)
            data.insert(localItem, at: 0)
            if cell.isPinned {
                let localArray = data.filter { !$0.isPinned }.sorted { $0.sortingNumber < $1.sortingNumber }
                data.removeAll { !$0.isPinned }
                data.append(contentsOf: localArray)
            }
        }
    }
    
    
    func getIndex(of item: String) -> Int {
        data.firstIndex(where: { $0.text == item }) ?? 0
    }
    
    func gestureAction(for content: CellModel, and cellWidth: CGFloat, actionType: SwipeButtonType) -> some Gesture {
        let index = getIndex(of: content.text)
        return DragGesture()
            .onChanged { [self] value in
                withAnimation {
                    switch content.cellPosition {
                    case .initial:
                        if value.translation.width < 0 || value.translation.width <= 90 {
                            data[index].offset = value.translation.width
                            
                        } else if value.translation.width > 90 {
                            data[index].offset = 90
                            
                        } else {
                            data[index].offset = 0
                        }
                    case .leftThresholdReached:
                        
                        if value.translation.width > 0 {
                            data[index].offset = 90
                            
                        } else if value.translation.width > -90 {
                            data[index].offset = value.translation.width
                    
                        } else {
                            data[index].offset = 0
                        }
                    
                    case .rightThresholdReached:
                        print("🎃 Right Threshold ")
                        if value.translation.width < 0 {
                            data[index].offset = value.translation.width - 90
                    
                        } else {
                            data[index].offset = 0
                        }
                    }
                }
            }
            .onEnded { [self] value in
                withAnimation {
                    switch content.cellPosition {
                    case .initial:
                        if value.translation.width <= -cellWidth * 0.7 {
                            data[index].offset = -500
                            buttonAction(of: actionType, with: content)
                            
                        } else if value.translation.width > -cellWidth * 0.7 && value.translation.width < 0 {
                            data[index].offset = -90
                            data[index].cellPosition = .rightThresholdReached
                            
                        } else if value.translation.width > 0 {
                            data[index].offset = 90
                            data[index].cellPosition = .leftThresholdReached
                        
                        } else if value.translation.width > -90 {
                            data[index].offset = 0
                            
                        } else {
                            data[index].offset = 0
                        }

                    case .leftThresholdReached:
                        if value.translation.width <= -10 {
                            data[index].offset = 0
                            data[index].cellPosition = .initial
                            
                        } else {
                            data[index].offset = 90
                        }
                        
                    case .rightThresholdReached:
                        
                        if value.translation.width >= 10 {
                            data[index].offset = 0
                            data[index].cellPosition = .initial
                            
                        } else if value.translation.width <= -cellWidth * 0.7 {
                            data[index].offset = -500
                            buttonAction(of: actionType, with: content)
                            
                        } else {
                            data[index].offset = -90
                        }
                    }
                }
            }
    }
}
