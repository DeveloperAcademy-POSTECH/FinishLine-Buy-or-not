//
//  Search.swift
//  Buy or Not
//
//  Created by Noah's Ark on 2022/04/06.
//

import SwiftUI

struct Search: View {
    
    @State var searchText: String = ""
    @State var selectedPageIndex = 1
    
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
                            TextField("검색", text: $searchText)
                                .frame(width: 290)
                                .background(Color(hex: "e9e9ea"))
                            
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
        
                // Tap bars in the upper section
                Picker("Favorite Color", selection: $selectedPageIndex, content: {
                    Text("답변 진행 중").tag(0)
                    Text("모두 보기").tag(1)
                    Text("답변 완료").tag(2)
                })
                .pickerStyle(SegmentedPickerStyle()) // <1>
                .padding(.horizontal, 15)
            }
            
            Spacer()
            
            // Picker will show different views based on its constant
            if (selectedPageIndex == 0) {
                Feed()
            } else if (selectedPageIndex == 1) {
                Feed2()
            } else if (selectedPageIndex == 2) {
                VStack {
                    Feed()
                    Feed2()
                }

            }
        
        }
    }
}

struct Search_Previews: PreviewProvider {
    static var previews: some View {
        Search()
    }
}
