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
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @FetchRequest(sortDescriptors: []) private var flowers: FetchedResults<Flower>
    
    @State private var showAddFlowerView = false
    @State private var image: Data = .init(count: 0)
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    HStack {
                        Text("Flowers")
                            .font(Font.custom("JosefinSans-Bold", size: 30))
                        Spacer()
                    }.padding(.leading)
                    Spacer()
                    ScrollView {
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2)) {
                            
                            ForEach(flowers) { flower in
                                NavigationLink {
                                    
                                    FlowerView( flower: flower)
                                    
                                } label: {
                                    ZStack {
                                        Rectangle().foregroundColor(.white).frame(width: 165, height: 180).cornerRadius(20, antialiased: true).shadow(color: Color(.gray), radius: 5.0).overlay(
                                            RoundedRectangle(cornerRadius: 20)
                                                .stroke(.clear))
                                        
                                        VStack {
                                            ZStack {
                                                Image(uiImage: UIImage(data: flower.image ?? self.image)!)
                                                    .renderingMode(.original)
                                                    .resizable()
                                                    .frame(width: 165, height: 150)
                                                    .clipShape(RoundedRectangle(cornerRadius: 20))
                                                HStack {
                                                    Spacer()
                                                    Button {
                                                        moc.delete(flower)
                                                        try? moc.save()
                                                    } label: {
                                                        Text("x")
                                                            .fontWeight(.heavy)
                                                            .foregroundColor(.white)
                                                            
                                                    }
                                                }
                                                .offset(y: -60)
                                                .padding()
                                            }
                                            Spacer()
                                            
                                            Text(flower.name!)
                                                .foregroundColor(.black)
                                                .font(.custom("JosefinSans-Medium", size: 18))
                                                .padding(.bottom)
                                        }
                                    }
                                }
                            }
                        }.padding(.top)
                    }
                    
                    
                    Spacer()
                    HStack {
                        Button {
                            showAddFlowerView.toggle()
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 35)
                                    .frame(width: 170, height: 40)
                                    .foregroundColor(Color(red: 255/255, green: 105/255, blue: 120/255))
                                
                                Text("Choose my flower")
                                    .font(Font.custom("JosefinSans-Medium", size: 18))
                                    .foregroundColor(Color(red: 255/255, green: 252/255, blue: 249/255))
                            }
                        }
                        .sheet(isPresented: $showAddFlowerView) {
                            AddFlowerView()
                        }
                        
                        Button {
                            
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 35)
                                    .frame(width: 170, height: 40)
                                    .foregroundColor(Color(red: 255/255, green: 105/255, blue: 120/255))
                                
                                Text("Choose fo me")
                                    .font(Font.custom("JosefinSans-Medium", size: 18))
                                    .foregroundColor(Color(red: 255/255, green: 252/255, blue: 249/255))
                            }
                        }
                    }.padding(.bottom)
                }
            }
            .preferredColorScheme(.light)
            .padding()
        }
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

