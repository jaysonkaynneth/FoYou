//
//  ContentView.swift
//  FoYou
//
//  Created by Jason Kenneth on 11/02/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var moc
    
    @FetchRequest(
        sortDescriptors: []) private var items: FetchedResults<Flower>
    
    var body: some View {
        VStack {
            HStack {
                Text("Flowers")
                    .font(Font.custom("JosefinSans-Bold", size: 30))
                Spacer()
            }.padding(.leading)
            
            ZStack {
                Button {
                    
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 35)
                            .frame(width: 200, height: 60)
                            .foregroundColor(Color(red: 255/255, green: 105/255, blue: 120/255))
                        
                        Text("I want flowers")
                            .foregroundColor(Color(red: 255/255, green: 252/255, blue: 249/255))
                    }
                }
            }
            Spacer()
        }
        .ignoresSafeArea()
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// colors:
// pink: FF6978 255 105 120
// white: FFFCF9 255 252 249
// green: 73A580 115 165 128
// dark green: 455E4E 69 94 78
//
//
//
//
//
