//
//  Feed.swift
//  Buy or Not
//
//  Created by Noah's Ark on 2022/04/06.
//

import SwiftUI

struct Feed: View {
    
    @State var selectedPageIndex = 1
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Image("sampleMan")
                        .resizable()
                        .frame(width: 110, height: 110)
                        .cornerRadius(20)
                        .padding(.leading, 10)
                    
                    Spacer()
                    
                    VStack (alignment: .leading) {
                        
                        Text("어디어디 제품이고 가격이 얼마인데 살지 말지 고민이 되네요...")
                            .font(.system(size: 20))
                            .fontWeight(.bold)
                            .padding(.top, 10)
                        
                        Spacer()
                        
                        HStack {
                            
                            Text("songcool")
                                .font(.system(size: 9))
                            
                            Spacer()
                            
                            HStack {
                                HStack {
                                    Image(systemName: "checkmark.square")
                                        .resizable()
                                        .frame(width: 9, height: 9)
                                        .foregroundColor(.gray)
                                    Text("16")
                                        .font(.system(size: 9))
                                        .foregroundColor(.gray)
                                }
                                
                                HStack {
                                    Image(systemName: "text.bubble")
                                        .resizable()
                                        .frame(width: 9, height: 9)
                                        .foregroundColor(.gray)
                                    Text("21")
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
                .padding(.horizontal, 15)
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
        Feed()
    }
}
