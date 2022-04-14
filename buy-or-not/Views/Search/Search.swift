//
//  Search.swift
//  Buy or Not
//
//  Created by Noah's Ark on 2022/04/06.
//
import SwiftUI

struct Search: View {
    
    @State var searchText: String = ""
    @Binding var data: QuestionItemManager
    
    var body: some View {
        VStack {
            // SearchBar and Picker Container
            VStack {
                VStack {
                    // Searchbar Container
                    VStack {
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                            
                            // TextField does not come up with Keyboard
                            TextField("검색", text: $searchText)
                                .frame(width: 290, height: 25)
                                .background(Color(hex: "e9e9ea"))
                                .foregroundColor(Color(hex: "#000000"))
                            
                            
                            
                            if (searchText != "") {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.gray)
                                    .onTapGesture {
                                        searchText = ""
                                    }
                            }
                            
                        }
                    }
                }
                .frame(width: 350, alignment: .leading)
                .padding(.horizontal, 5)
                .padding(.vertical, 9)
                .background(Color(hex: "e9e9ea"))
                .cornerRadius(10)
                
                Spacer()
                
                AllPosts(
                    searchText: searchText,
                    data: data
                ).padding(.horizontal)

        
            }
        }
        .navigationBarTitle("검색")
    }
}
