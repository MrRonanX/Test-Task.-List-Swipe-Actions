//
//  CustomizedListViewMode.swift
//  Test Task. List Swipe Actions
//
//  Created by Roman Kavinskyi on 8/1/21.
//

import SwiftUI

final class CustomizedListViewModel: ObservableObject {
    @Published var data = (1...10).map { CellModel(text: String($0), sortingNumber: $0) }
    var newCellActivated = false
    
    
    func primaryButtonAction(of cell: CellModel) {
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
    
    
    func setOffsetToZero(with cell: CellModel) {
        guard newCellActivated else { return }
        newCellActivated = false
        for index in data.indices {
            if data[index].id.uuidString != cell.id.uuidString {
                withAnimation(.easeIn) {
                    data[index].offset = 0
                    data[index].cellPosition = .initial
                }
            }
        }
    }
    
    
    func gestureAction(for content: CellModel, and cellWidth: CGFloat) -> some Gesture {
        let index = getIndex(of: content.text)
        return DragGesture()
            .onChanged { [self] value in
                switch content.cellPosition {
                case .initial:
                    setOffsetToZero(with: content)
                    
                    if value.translation.width < 0 {
                        data[index].offset = value.translation.width
                        
                    } else if value.translation.width <= 90 {
                        withAnimation(.linear) { data[index].offset = value.translation.width }
                        
                    } else if value.translation.width > 90 {
                        data[index].offset = 90
                        
                    } else {
                        withAnimation(.linear) { data[index].offset = 0 }
                    }
                    
                case .leftThresholdReached:
                    if value.translation.width > 0 {
                        data[index].offset = 90
                        
                    } else if value.translation.width > -90 {
                        withAnimation(.linear) { data[index].offset = value.translation.width }
                        
                    } else {
                        withAnimation(.linear) { data[index].offset = 0 }
                    }
                    
                case .rightThresholdReached:
                    if value.translation.width < 0 {
                        withAnimation(.linear) { data[index].offset = value.translation.width - 90 }
                        
                    } else {
                        withAnimation { data[index].offset = 0 }
                    }
                }
            }
            .onEnded { [self] value in
                withAnimation(.easeIn) {
                    switch content.cellPosition {
                    case .initial:
                        if value.translation.width <= -cellWidth * 0.7 {
                            data[index].offset = -500
                            primaryButtonAction(of: content)
                            
                        } else if value.translation.width > -cellWidth * 0.7 && value.translation.width < 0 {
                            data[index].offset = -90
                            data[index].cellPosition = .rightThresholdReached
                            newCellActivated = true
                            
                        } else if value.translation.width > 0 {
                            data[index].offset = 90
                            data[index].cellPosition = .leftThresholdReached
                            newCellActivated = true
                            
                        } else if value.translation.width > -90 {
                            data[index].offset = 0
                            
                        } else {
                            data[index].offset = 0
                        }
                        
                    case .leftThresholdReached:
                        if value.translation.width <= -10 {
                            data[index].offset = 0
                            data[index].cellPosition = .initial
                            newCellActivated = false
                            
                        } else {
                            data[index].offset = 90
                        }
                        
                    case .rightThresholdReached:
                        if value.translation.width >= 10 {
                            data[index].offset = 0
                            data[index].cellPosition = .initial
                            newCellActivated = false
                            
                        } else if value.translation.width <= -cellWidth * 0.7 {
                            data[index].offset = -500
                            primaryButtonAction(of: content)
                            
                        } else {
                            data[index].offset = -90
                            newCellActivated = true
                        }
                    }
                }
            }
    }
}
