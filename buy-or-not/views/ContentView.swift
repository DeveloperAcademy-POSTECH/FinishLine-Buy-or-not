//
//  ContentView.swift
//  buy-or-not
//
//  Created by Noah's Ark on 2022/04/06.
//
//  test

import SwiftUI

struct ContentView: View {
    
    var userData = UserManager()
    
    
    var body: some View {
        NavigationView {
            VStack {
                Text("사용자 샘플 테스트 중입니다. 테오")
                    .padding()

                NavigationLink( destination: Search() ) {
                    VStack {
                        Image("questionButton").font(.largeTitle)
                        Text("탈출 버튼")
                    }
                }
                
                ForEach (userData.json) {data in
                    VStack {
                        HStack {
                            AsyncImage(url: URL(string: data.imageURL))
                                .frame(width: 110, height: 110)
                                .cornerRadius(8)
                            VStack {
                                Text(data.email)
                                Text(data.nickName)
                            }
                        }
                        HStack{
                            ForEach(data.favorites, id: \.self) {favorite in
                               
                                ZStack (alignment: .bottomTrailing) {
                                    if favorite.checked {
                                        Image(systemName: favorite.category)
                                            .resizable()
                                            .frame(width: 30, height: 30)
                                            .padding(.horizontal, 10)
                                        
                                        if favorite.awarded {
                                            Image(systemName: "heart.fill")
                                                .resizable()
                                                .frame(width: 15, height: 15)
                                                .foregroundColor(.red)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

