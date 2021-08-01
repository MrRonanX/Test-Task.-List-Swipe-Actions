//
//  ClassicList.swift
//  Test Task. List Swipe Actions
//
//  Created by Roman Kavinskyi on 8/1/21.
//

import SwiftUI

struct ClassicList: View {
    
    @State var listItems = (1...10).map { ListItemModel(name: String($0)) }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(listItems) {
                    Text($0.name)
                }
                .onDelete(perform: deleteItem)
            }
            .navigationTitle("Classic List")
            .navigationBarTitleDisplayMode(.inline)
            
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
            }
        }
    }
    
    private func deleteItem(at offsets: IndexSet) {
        listItems.remove(atOffsets: offsets)
    }
}

struct ClassicList_Previews: PreviewProvider {
    static var previews: some View {
        ClassicList()
    }
}

struct ListItemModel: Identifiable {
    let id = UUID()
    let name: String
}
