//
//  MainView.swift
//  FoYou
//
//  Created by Jason Kenneth on 11/02/23.
//

import SwiftUI

struct MainView: View {
    
    init() {
        UITabBar.appearance().unselectedItemTintColor = UIColor(Color(red: 252/255, green: 250/255, blue: 250/255).opacity(0.25))
    }
    
    @State private var tabSelection = 0
   
    var body: some View {
        TabView(selection: $tabSelection) {
            ContentView().tabItem {
                if tabSelection == 0 {
                           Image("HouseIcon")
                       } else {
                           Image("HouseFadeIcon")
                       }
                       Text("All Items")
                    .font(Font.custom("DMSans-Medium", size: 18))
            }.tag(0)
            
            SavedView().tabItem {
                if tabSelection == 1 {
                           Image("ListIcon")
                       } else {
                           Image("ListFadeIcon")
                       }
                       Text("Shopping List")
                    .font(Font.custom("DMSans-Medium", size: 18))
            }.tag(1)
      
        }
        .background(Color(red: 252/255, green: 250/255, blue: 250/255))
        .preferredColorScheme(.light)
        .tint(Color(red: 252/255, green: 250/255, blue: 250/255))
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

