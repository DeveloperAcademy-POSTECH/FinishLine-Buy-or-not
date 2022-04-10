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
    var options: [Options]
    
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
                                .font(.system(size: 11))
                            
                            Spacer()
                            
                            HStack {
                                HStack {
                                    Image(systemName: "checkmark.square")
                                        .resizable()
                                        .frame(width: 11, height: 11)
                                        .foregroundColor(.gray)
                                    Text("\(votes)")
                                        .font(.system(size: 11))
                                        .foregroundColor(.gray)
                                }
                                
                                HStack {
                                    Image(systemName: "text.bubble")
                                        .resizable()
                                        .frame(width: 11, height: 11)
                                        .foregroundColor(.gray)
                                    Text("\(comments)")
                                        .font(.system(size: 11))
                                        .foregroundColor(.gray)
                                }
                            }
                            .padding(.trailing, 15)
                        }
                    }
                    .frame(width: 220, height: 120 ,alignment: .leading)
                }
                .frame(width: 360, height: 120)
                
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(height: 40)
                        .foregroundColor(Color(hex: "F2F2F7"))
                    VoteButtons(data: options)
                }.frame(height: 40)

                Spacer()
                
                Divider()
                    .frame(width: 360, height: 1.2)
                    .background(Color(hex: "#EEE"))

            }
        }
    }
}
