//
//  ContentView.swift
//  Test Task. List Swipe Actions
//
//  Created by Roman Kavinskyi on 7/31/21.
//

import SwiftUI

struct CustomizedList: View {
    @StateObject var viewModel = CustomizedListViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                GeometryReader { geo in
                    LazyVStack(alignment: .leading, spacing: 0) {
                        ForEach(viewModel.data) { content in
                            CellView(content: content, width: geo.size.width, buttonType: viewModel.allButtonTypes[content.buttonNumber])
                                .environmentObject(viewModel)
                        }
                        
                    }
                }
            }
            .navigationTitle("Action List")
            .navigationBarTitleDisplayMode(.inline)
            
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CustomizedList()
    }
}


