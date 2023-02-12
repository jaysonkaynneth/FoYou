//
//  AddFlowerView.swift
//  FoYou
//
//  Created by Jason Kenneth on 11/02/23.
//

import SwiftUI
import PhotosUI

struct AddFlowerView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var name: String = ""
    @State private var url: String = ""
    @State private var image: Data = .init(count: 0)
    @State private var selectedItems: [PhotosPickerItem] = []
    @State private var placeHolderImage: Data = .init(count: 0)
    
    var body: some View {
        ZStack {
            VStack {
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
                            Text("Photo")
                                .font(Font.custom("JosefinSans-Bold", size: 30))
                                .tint(.blue)
                                .frame(width: 350, height: 200)
                                .overlay(RoundedRectangle(cornerRadius: 30)
                                    .stroke((Color(red: 255/255, green: 105/255, blue: 120/255)), lineWidth: 4))
                                .clipShape(
                                    RoundedRectangle(cornerRadius: 30))
                            
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
                    let flower = Flower(context: moc)
                    
                    flower.name = (name)
                    flower.url = (url)
                    flower.image = (image)
                    flower.isFavorite = false
                  
                    try! moc.save()
                    presentationMode.wrappedValue.dismiss()
                    print(flower.name!)
                    print(flower.url!)
                    print(flower.isFavorite)
                
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 35)
                            .frame(width: 170, height: 60)
                        
                        Text("Save")
                            .font(Font.custom("JosefinSans-Medium", size: 18))
                            .foregroundColor(Color(red: 252/255, green: 252/255, blue: 249/255))
                    }
                }
                .disabled(name.isEmpty || image.isEmpty)
                .foregroundColor(Color(red: 255/255, green: 105/255, blue: 120/255))
            }
        }
        .padding()
        .navigationBarHidden(true)
        .navigationBarTitle("")
    }
}

struct AddFlowerView_Previews: PreviewProvider {
    static var previews: some View {
        AddFlowerView()
    }
}
