//
//  AppTabView.swift
//  Test Task. List Swipe Actions
//
//  Created by Roman Kavinskyi on 8/1/21.
//

import SwiftUI

struct AppTabView: View {
    var body: some View {
        TabView {
            ClassicList()
                .tabItem {
                    Label("Classic List", systemImage: "list.bullet.rectangle")
                }
            CustomizedList()
                .tabItem {
                    Label("Customized List", systemImage: "list.star")
                }
        }
    }
}

struct AppTabView_Previews: PreviewProvider {
    static var previews: some View {
        AppTabView()
    }
}
