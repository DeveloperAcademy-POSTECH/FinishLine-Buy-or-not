//
//  Feed.swift
//  Buy or Not
//
//  Created by Noah's Ark on 2022/04/06.
//

import SwiftUI

struct Feed: View {
    
    @State var selectedPageIndex = 1
    
    var title: String
    var author: String
    var votes: Int
    var comments: Int
    var imageURL: String
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    AsyncImage(url: URL(string: imageURL))
                        .frame(width: 110, height: 110)
                        .cornerRadius(20)
                        .padding(.leading, 10)
                    
                    Spacer()
                    
                    VStack (alignment: .leading) {
                        
                        Text(title)
                            .font(.system(size: 20))
                            .fontWeight(.bold)
                            .padding(.top, 10)
                        
                        Spacer()
                        
                        HStack {
                            
                            Text(author)
                                .font(.system(size: 9))
                            
                            Spacer()
                            
                            HStack {
                                HStack {
                                    Image(systemName: "checkmark.square")
                                        .resizable()
                                        .frame(width: 9, height: 9)
                                        .foregroundColor(.gray)
                                    Text("\(votes)")
                                        .font(.system(size: 9))
                                        .foregroundColor(.gray)
                                }
                                
                                HStack {
                                    Image(systemName: "text.bubble")
                                        .resizable()
                                        .frame(width: 9, height: 9)
                                        .foregroundColor(.gray)
                                    Text("\(comments)")
                                        .font(.system(size: 9))
                                        .foregroundColor(.gray)
                                }
                            }
                            .padding(.trailing, 15)
                        }
                    }
                    .frame(width: 220, height: 120 ,alignment: .leading)
                }
                .frame(width: 360, height: 120)
             
                Picker("Favorite Color", selection: $selectedPageIndex, content: {
                    Text("이거").tag(0)
                    Text("저거").tag(1)
                    Text("그거").tag(2)
                })
                .pickerStyle(SegmentedPickerStyle()) // <1>
                .padding(.horizontal, 30)
            }
                
            Divider()
                .frame(width: 360, height: 1.2)
                .background(Color(hex: "#EEE"))

            Spacer()
        }
    }
}

struct Feed_Previews: PreviewProvider {
    static var previews: some View {
        Feed(
            selectedPageIndex: 1,
            title: "Hello",
            author: "Lorem",
            votes: 10,
            comments: 100,
            imageURL: "https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fstatic.onecms.io%2Fwp-content%2Fuploads%2Fsites%2F13%2F2015%2F04%2F05%2Ffeatured.jpg"
        )
    }
}
