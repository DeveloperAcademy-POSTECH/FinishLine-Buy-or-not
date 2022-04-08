//
//  Main.swift
//  buy-or-not
//
//  Created by leejunmo on 2022/04/06.
//
// 메인페이지입니다.

import SwiftUI

struct MainCategorys: View{
    let mainCategorys: [String] = [
        "모두보기", "for you", "패션/뷰티", "가구/인테리어", "식품/외식", "전자제품", "취미/여가", "기타"]
    @State private var scrollers: Bool = true
    private var moreOrLess = "􀆈"
    var body: some View{
        ZStack{
            HStack{
                if scrollers{
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack{
                            ForEach(mainCategorys, id: \.self){ c in
                                Button(c) {
                                    /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
                                }.foregroundColor(.white)
                                    .frame( height: 30, alignment: .center)
                                    .background(.gray)
                                    .cornerRadius(20)
                                    .padding(.vertical, 24.0)
                                    .buttonStyle(.bordered)
                            }
                        }
                    }
                }
                
                else{
                    let gridItems = [GridItem(.fixed(100)),
                                     GridItem(.fixed(100)),
                                     GridItem(.fixed(100))]
                    
                    LazyVGrid(columns: gridItems){
                        ForEach(mainCategorys, id: \.self){ c in Button(c) {
                            /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
                        }.foregroundColor(.white)
                                .frame(width:100, height: 30, alignment: .center)
                                .background(.gray)
                                .cornerRadius(20)
                        }
                    }
                }
                
                Spacer()
                Button("􀆈") {
                    scrollers.toggle()
                }.foregroundColor(.white)
                    .frame( height: 30, alignment: .center)
                    .background(.gray)
                    .cornerRadius(20)
                    .padding(.vertical, 24.0)
                    .buttonStyle(.bordered)
            }
        }
    }
    
}
