//
//  StartUpView.swift
//  FoYou
//
//  Created by Jason Kenneth on 11/02/23.
//

import SwiftUI

struct StartUpView: View {
    
    @Environment(\.managedObjectContext) var moc
    @Binding var showStartUp: Bool
    
    @State private var showAlert1 = false
    @State private var showAlert2 = false
    @State private var showAlert3 = false
    @State private var showAlert4 = false
    @State private var showAlert5 = false
    @State private var counter = 0
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            HStack {
                Text("HAPPY VALENTINES DAY, BABE!")
                    .font(Font.custom("JosefinSans-Bold", size: 45))
                Spacer()
            }
            .padding(.leading)
            .padding(.top)
            
            HStack {
                Text("Since you like flowers so much, I made you this application to select and save flowers you want!")
                    .font(Font.custom("JosefinSans-Regular", size: 20))
            } .padding(.horizontal)
           
            HStack {
                Text("BUT FIRST,")
                    .font(Font.custom("JosefinSans-Bold", size: 30))
                Spacer()
            }
            .padding(.leading)
            .padding(.top)
            
            HStack {
                Text("Will you be my valentine?")
                    .font(Font.custom("JosefinSans-Regular", size: 20))
                Spacer()
            }
            .padding(.horizontal)
            .padding(.bottom)
            
            HStack {
                Button {
                    showStartUp.toggle()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 35)
                            .frame(width: 170, height: 60)
                        
                        Text("OMG YES!")
                            .font(Font.custom("JosefinSans-Medium", size: 18))
                            .foregroundColor(Color(red: 252/255, green: 252/255, blue: 249/255))
                    }
                }
                .foregroundColor(Color(red: 255/255, green: 105/255, blue: 120/255))
                
                Button {
                    counter += 1
                    
                    if counter == 3 {
                        showAlert1 = true
                    }
                    else if counter == 7 {
                        showAlert2 = true
                    }
                    else if counter == 12 {
                        showAlert3 = true
                    }
                    else if counter > 12 && counter <= 19 {
                        showAlert4 = true
                    }
                    else if counter == 20 {
                        showAlert5 = true
                    }
                    
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 35)
                            .frame(width: 170, height: 60)
                        
                        Text("no.")
                            .font(Font.custom("JosefinSans-Medium", size: 20))
                            .foregroundColor(Color(red: 252/255, green: 252/255, blue: 249/255))
                    }
                }
                .foregroundColor(Color(red: 173/255, green: 46/255, blue: 36/255))
                .alert("Haha very funny. Now please press yes <3.", isPresented: $showAlert1) {
                       Button("Haha", role: .cancel) { }
                   }
                .alert("Not funny anymore. Press yes please!", isPresented: $showAlert2) {
                       Button("Mhm", role: .cancel) { }
                   }
                .alert("I can do this all day you know.", isPresented: $showAlert3) {
                       Button("Nope", role: .cancel) { }
                   }
                .alert("Yes.", isPresented: $showAlert4) {
                       Button("No.", role: .cancel) { }
                   }
                .alert("Fine you win.", isPresented: $showAlert5) {
                       Button("Ok!", role: .cancel) {
                           closeApp()
                       }
                   }
            }.padding(.horizontal)
            Spacer()
        }
        .background(Color(red: 252/255, green: 252/255, blue: 249/255))
        .preferredColorScheme(.light)
    }
    func closeApp() {
        let x = 1
        
        assert(x == 0)
    }
}

struct StartUpView_Previews: PreviewProvider {
    static var previews: some View {
        StartUpView(showStartUp: .constant(true))
    }
}

// colors:
// pink: FF6978 255 105 120
// white: FFFCF9 255 252 249
// green: 73A580 115 165 128
// dark green: 455E4E 69 94 78

