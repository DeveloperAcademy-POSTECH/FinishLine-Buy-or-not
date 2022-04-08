//
//  Search.swift
//  Buy or Not
//
//  Created by Noah's Ark on 2022/04/06.
//

import SwiftUI

struct Search: View {
    
    @State var searchTextInProgress: String = ""
    @State var searchTextInAll: String = ""
    @State var searchTextInClosed: String = ""
    @State var selectedPageIndex: Int = 1
    
    var data = QuestionItemManager()
    
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
                                TextField("검색", text:
                                            selectedPageIndex == 0 ? $searchTextInProgress
                                          : selectedPageIndex == 1 ? $searchTextInAll
                                          : $searchTextInClosed
                                )
                                    .frame(width: 290, height: 25)
                                    .background(Color(hex: "e9e9ea"))
                                    .foregroundColor(Color(hex: "#000000"))
                                
                                
                                
                                if (searchTextInProgress != "" || searchTextInAll != "" || searchTextInClosed != "") {
                                    Image(systemName: "xmark.circle.fill")
                                        .foregroundColor(.gray)
                                        .onTapGesture {
                                            searchTextInProgress = ""
                                            searchTextInAll = ""
                                            searchTextInClosed = ""
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
                    Picker(
                        "Favorite Color",
                        selection: $selectedPageIndex,
                        content: {
                            Text("답변 진행 중").tag(0)
                            Text("모두 보기").tag(1)
                            Text("답변 완료").tag(2)
                    })
                    .pickerStyle(SegmentedPickerStyle()) // <1>
                    .padding(.horizontal, 15)
                    .onChange(of: selectedPageIndex) { index in
                        switch (index) {
                        case 0:
                            searchTextInAll = ""
                            searchTextInClosed = ""
                        case 1:
                            searchTextInProgress = ""
                            searchTextInClosed = ""
                            case 2:
                            searchTextInAll = ""
                            searchTextInClosed = ""
                        default:
                            searchTextInProgress = ""
                            searchTextInAll = ""
                            searchTextInClosed = ""
                        }
                    }
                }
                
                Spacer()
                
                // Picker will show different views based on its constant
                if (selectedPageIndex == 0) {
                    QuestionOnGoing(
                        searchText: searchTextInProgress,
                        data: data
                    )
                } else if (selectedPageIndex == 1) {
                    AllPosts(data: data)
                    
                } else if (selectedPageIndex == 2) {
                    QuestionClosed(data: data)
                }
            }
            .navigationBarTitle("검색")
        }
}

struct Search_Previews: PreviewProvider {
    static var previews: some View {
        Search()
    }
}
