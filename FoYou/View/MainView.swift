//
//  MainView.swift
//  FoYou
//
//  Created by Jason Kenneth on 11/02/23.
//

import SwiftUI

struct MainView: View {
    
    @AppStorage("showStartUp") var showStartUp: Bool = true
    
    init() {
        UITabBar.appearance().unselectedItemTintColor = UIColor(.gray)
    }
    
    @State private var tabSelection = 0
    
    var body: some View {
        TabView(selection: $tabSelection) {
            ContentView().tabItem {
                if tabSelection == 0 {
                    Image(systemName: "camera.macro")
                } else {
                    Image(systemName: "camera.macro")
                }
                Text("Flowers")
                    .font(Font.custom("JosefinSans-Regular", size: 18))
            }.tag(0)
            
            SavedView().tabItem {
                if tabSelection == 1 {
                    Image(systemName: "heart.fill")
                } else {
                    Image(systemName: "heart")
                }
                Text("Favorites")
                    .font(Font.custom("JosefinSans-Regular", size: 18))
            }.tag(1)
            
        }
        .background(Color(red: 252/255, green: 252/255, blue: 249/255))
        .preferredColorScheme(.light)
        .tint(Color(red: 255/255, green: 105/255, blue: 120/255))
        .fullScreenCover(isPresented: $showStartUp, content: {
                StartUpView(showStartUp: $showStartUp)
            })
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

// colors:
// pink: FF6978 255 105 120
// lav pink: F0A6CA 240 166 202
// white: FFFCF9 255 252 249
// green: 73A580 115 165 128
// dark green: 455E4E 69 94 78

