//
//  FlowerView.swift
//  FoYou
//
//  Created by Jason Kenneth on 11/02/23.
//

import SwiftUI
import PhotosUI

struct FlowerView: View {
    @Environment(\.managedObjectContext) private var moc
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    let flower: Flower
    
    @State private var showTabBar = false
    @State private var name: String = ""
    @State private var url: String = ""
    @State private var image: Data = .init(count: 0)
    @State private var selectedItems: [PhotosPickerItem] = []
    @State private var placeHolderImage: Data = .init(count: 0)
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                        showTabBar.toggle()
                    } label: {
                        Text("Back")
                    }
                    .foregroundColor(Color(red: 255/255, green: 105/255, blue: 120/255))
                    
                    Spacer()
                    
                    Button {
                    openWhatsapp()
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 35)
                                .frame(width: 170, height: 30)
                            
                            Text("Notify Boyfriend")
                                .font(Font.custom("JosefinSans-Medium", size: 18))
                                .foregroundColor(Color(red: 252/255, green: 252/255, blue: 249/255))
                        }
                    }
                    .foregroundColor(Color(red: 255/255, green: 105/255, blue: 120/255))
                }
                .padding(.trailing)
                .padding(.bottom)
                
                HStack {
                    
                    PhotosPicker(selection: $selectedItems,
                                 maxSelectionCount: 1,
                                 matching: .images) {
                        if selectedItems.count != 0 {
                            if let data = image, let uiImage = UIImage(data: data) {
                                Image(uiImage: uiImage)
                                    .renderingMode(.original)
                                    .resizable()
                                    .frame(width: 350, height: 200)
                                    .clipShape(
                                        RoundedRectangle(cornerRadius: 20)
                                    )
                            }
                            
                        } else {
                            Image(uiImage: UIImage(data: flower.image ?? self.image)!)
                                .renderingMode(.original)
                                .resizable()
                                .frame(width: 350, height: 200)
                                .clipShape(
                                    RoundedRectangle(cornerRadius: 20)
                                )
                        }
                    }
                    
                 
                }
                .padding(.horizontal)
                .onChange(of: selectedItems) { new in
                        guard let items = selectedItems.first else { return
                            
                        }
                        
                        items.loadTransferable(type: Data.self) { result in
                            switch result {
                            case .success(let data):
                                if let data = data {
                                    self.image = data
                                } else {
                                    print("No data :(")
                                }
                            case .failure(let error):
                                fatalError("\(error)")
                            }
                        }
                        
                    }
                
                HStack {
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Flower Name")
                                .font(Font.custom("JosefinSans-Medium", size: 18))
                                .padding(.leading, 8)
                        }
                        TextField("", text: $name)
                            .frame(width: 350, height: 35)
                            .tint(Color(red: 77/255, green: 108/255, blue: 250/255))
                            .padding(.leading, 10)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundColor(Color(red: 240/255, green: 166/255, blue: 202/255))
                                    .opacity(0.4)
                                    .frame(width: 350, height: 35)
                            )
                    }
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top)
                
                HStack {
                    VStack(alignment: .leading) {
                        HStack {
                            Text("URL (link to where you saw it)")
                                .font(Font.custom("JosefinSans-Medium", size: 18))
                                .padding(.leading, 8)
                        }
                        TextField("", text: $url)
                            .frame(width: 350, height: 35)
                            .tint(Color(red: 77/255, green: 108/255, blue: 250/255))
                            .padding(.leading, 10)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundColor(Color(red: 240/255, green: 166/255, blue: 202/255))
                                    .opacity(0.4)
                                    .frame(width: 350, height: 35)
                            )
                    }
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top)
                
                Spacer()
                
                Button {
                    
                    if name.isEmpty {
                        flower.name = flower.name
                    } else if !name.isEmpty {
                        flower.name = (name)
                    }
                    
                    if url.isEmpty {
                        flower.url = flower.url
                    } else if !url.isEmpty {
                        flower.url = (url)
                    }
                    
                    if image.isEmpty {
                        flower.image = flower.image
                    } else if !image.isEmpty {
                        flower.image = (image)
                    }
                    
                    flower.name = (name)
                    flower.url = (url)
                    flower.image = (image)
                  
                    try! moc.save()
                    presentationMode.wrappedValue.dismiss()
                    print(flower.name!)
                    print(flower.url!)
                    print(flower.isFavorite)
                    
                    showTabBar = true
                
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 35)
                            .frame(width: 170, height: 60)
                        
                        Text("Save")
                            .font(Font.custom("JosefinSans-Medium", size: 18))
                            .foregroundColor(Color(red: 252/255, green: 252/255, blue: 249/255))
                    }
                }
                .foregroundColor(Color(red: 255/255, green: 105/255, blue: 120/255))
                
            }
        }
        .onAppear {
            self.name = flower.name ?? ""
            self.url = flower.url ?? "URL"
            self.image = flower.image!
        }
        .toolbar(showTabBar ? .visible : .hidden, for: .tabBar)
        .padding()
        .navigationBarHidden(true)
        .navigationBarTitle("")
    }
    
    func openWhatsapp() {
        let urlWhats = "whatsapp://send?phone=+6285171601601&text=I want this flower \"\(flower.name!)\" from here \(flower.url ?? "URL"). Fulfill your boyfriendly duties, please!"
        if let urlString = urlWhats.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed){
            if let whatsappURL = URL(string: urlString) {
                if UIApplication.shared.canOpenURL(whatsappURL){
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(whatsappURL, options: [:], completionHandler: nil)
                    } else {
                        UIApplication.shared.openURL(whatsappURL)
                    }
                }
                else {
                    print("Error")
                }
            }
        }
    }
}
