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
    @Environment(\.openURL) var openURL
    
    @FetchRequest(sortDescriptors: []) private var flowers: FetchedResults<Flower>
    
    @State private var showAddFlowerView = false
    @State private var image: Data = .init(count: 0)
    @State private var isPressed = false
    @State private var showAlert = false

    let flowerNames = ["Aconite",
                 "Ageratum",
                 "Allium",
                 "Anemone",
                 "Angelica",
                 "Angelonia",
                 "Artemisia",
                 "Aster",
                 "Astilbe",
                 "Aubrieta",
                 "Azalea",
                 "Balloon%20Flower",
                 "Balsam",
                 "Baneberry",
                 "Basket%20of%20Gold",
                 "Bee%20Balm",
                 "Begonia",
                 "Bellflower",
                 "Bergenia",
                 "Blackeyed%20Susan",
                 "Bleeding%20Heart",
                 "Bloodroot",
                 "Boneset",
                 "Browallia",
                 "Bugleweed",
                 "Bugloss",
                 "Buttercup",
                 "Butterfly%20Weed",
                 "Caladium",
                 "Calendula",
                 "California%20Poppy",
                 "Canterbury%20Bells",
                 "Cardinal%20Flower",
                 "Carnation",
                 "Castor Bean",
                 "Catmint",
                 "Celosia",
                 "Chives",
                 "Chrysanthemum",
                 "Clary%20Sage",
                 "Cleome",
                 "Coleus",
                 "Columbine",
                 "Comfrey",
                 "Coneflower",
                 "Coreopsis",
                 "Corydalis",
                 "Cosmos",
                 "Crocus",
                 "Crown%20Imperial",
                 "Cushion%20Spurge",
                 "Cyclamen",
                 "Daffodil",
                 "Dahlia",
                 "Daisy",
                 "Dames%20Rocket",
                 "Delphinium",
                 "Diascia",
                 "Dusty%20Miller",
                 "Dutchmans%20Breeches",
                 "Epimedium",
                 "Evergreen%20Candytuft",
                 "Fennel",
                 "Fountain%20Grass",
                 "Foxglove",
                 "Gaillardia",
                 "Gas%20Plant",
                 "Gaura",
                 "Gazania",
                 "Geranium",
                 "Geum",
                 "Globe%20Thistle",
                 "Glory%20of%20the%20Snow",
                 "Goatsbeard",
                 "Golden%20Marguerite",
                 "Gomphrena",
                 "Heliotrope",
                 "Hepatica",
                 "Hollyhock",
                 "Hosta",
                 "Hyacinth",
                 "Hyssop",
                 "Impatiens",
                 "Iris",
                 "Jack-in-the-Pulpit",
                 "Jacobs%20Ladder",
                 "Ladys%20Mantle",
                 "Lantana",
                 "Lavender",
                 "Lavender%20Cotton",
                 "Leadwort",
                 "Lemon%20Balm",
                 "Lily%20flower",
                 "Lobelia",
                 "Lupine",
                 "Maiden%20Pink",
                 "Malva",
                 "Marigold",
                 "Mazus",
                 "Mirabilis",
                 "Moonflower",
                 "Morning Glory",
                 "Nasturtium",
                 "Nierembergia",
                 "Orchid",
                 "Osteospermum",
                 "Pansy",
                 "Pearly%20Everlasting",
                 "Perennial Flax",
                 "Periwinkle",
                 "Petunia",
                 "Pincushion%20Flower",
                 "Polka%20Dot%20Plant",
                 "Primrose",
                 "Ranunculus",
                 "Red%20Valerian",
                 "Rock%20Soapwort",
                 "Rose%20flower",
                 "Rose%20buquet",
                 "White%20rose%20buquet",
                 "Rue%20flower",
                 "Sanvitalia",
                 "Scarlet%20Sage",
                 "Sea%20Lavender",
                 "Sea%20Thrift",
                 "Shirley%20Poppy",
                 "Shooting%20Star",
                 "Silvermound",
                 "Skunk%20Cabbage",
                 "Snapdragon",
                 "Snow%20in%20Summer",
                 "Snowdrop%20flower",
                 "Solomons%20Seal",
                 "Spring%20Snowflake",
                 "Summer%20Savory",
                 "Sunflower%20plant",
                 "Sweet%20Alyssum",
                 "Sweet%20Woodruff",
                 "Tansy",
                 "Thunbergia",
                 "Tithonia",
                 "Torenia",
                 "Trillium",
                 "Tulip",
                 "Verbena",
                 "Violet",
                 "Virginia%20Bluebell",
                 "Wild%20Senna",
                 "Windflower",
                 "Yarrow",
                 "Yellow%20Archangel",
                 "Yellow%20Loosestrife",
                 "Zinnia"]
    
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
                                                    Button {
                                                        isPressed.toggle()
                                                        flower.isFavorite.toggle()
                                                        try? moc.save()
                                                        print(flower.isFavorite)
                                                    } label: {
                                                        ZStack {
                                                            Circle()
                                                                .foregroundColor(.white)
                                                                .frame(width: 30, height: 30)
                                                                .shadow(radius: 4)
                                                            
                                                            Image(systemName: flower.isFavorite ? "heart.fill" : "heart")
                                                        }
                                                    }
                                                    Spacer()
                                                }.offset(x: 10, y: -55)
                                                HStack {
                                                    Spacer()
                                                    VStack {
                                                        Button {
                                                            showAlert = true
                                                        } label: {
                                                            Text("x")
                                                                .fontWeight(.heavy)
                                                                .foregroundColor(.white)
                                                            
                                                        }
                                                        .alert(isPresented: $showAlert) {
                                                            Alert(
                                                                title: Text("Delete this flower?"),
                                                                message: Text("Are you sure you want to delete this flower?"),
                                                                primaryButton: .destructive(Text("Yes"), action: {
                                                                    moc.delete(flower)
                                                                    try? moc.save()
                                                                    presentationMode.wrappedValue.dismiss()
                                                                }),
                                                                secondaryButton: .cancel(Text("No"), action: {
                                                                })
                                                            )
                                                        }
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
                            openURL(URL(string: "https://www.google.com/search?q=\(flowerNames.randomElement()!)")!)
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

