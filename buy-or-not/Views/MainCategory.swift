//
//  MainCategory.swift
//  buy-or-not
//
//  Created by 이지원 on 2022/04/07.
//

import SwiftUI

struct MainCategorys: View{
    let mainCategorys: [String] = [
        "모두보기", "for you", "패션/뷰티", "가구/인테리어", "식품/외식", "전자제품", "취미/여가", "기타"]
    private var moreOrLess = ["chevron.down", "chevron.up"]
    
    @State private var scrollers: Bool = true
    @State public var choiced: String = "모두보기"
    @State private var index = 0
    
    
    var body: some View{
        ZStack{
            HStack{
                if scrollers{
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack{
                            ForEach(mainCategorys, id: \.self){ c in
                                Button(c) {
                                    choiced = c
                                }.foregroundColor(.white)
                                    .frame( height: 30, alignment: .center)
                                    .background(self.choiced == c ? Color.blue : Color.gray)
                                    .cornerRadius(20)
                                    .padding(.vertical, 24.0)
                                    .buttonStyle(.bordered)
                            }
                        }
                    }
                    .mask(
                        HStack(spacing: 0) {

                            // Left gradient
                            LinearGradient(gradient:
                               Gradient(
                                   colors: [Color.black.opacity(0), Color.black]),
                                   startPoint: .leading, endPoint: .trailing
                               )
                               .frame(width: 15)

                            // Middle
                            Rectangle().fill(Color.black)

                            // Right gradient
                            LinearGradient(gradient:
                               Gradient(
                                   colors: [Color.black, Color.black.opacity(0)]),
                                   startPoint: .leading, endPoint: .trailing
                               )
                               .frame(width: 10)
                        }
                     )
                }
                
                else{
                    let gridItems = [GridItem(.fixed(100)),
                                     GridItem(.fixed(100)),
                                     GridItem(.fixed(100))]
                    
                    LazyVGrid(columns: gridItems){
                        ForEach(mainCategorys, id: \.self){ c in Button(c) {
                            choiced = c
                        }.foregroundColor(.white)
                                .frame(width:100, height: 30, alignment: .center)
                                .background(self.choiced == c ? Color.blue : Color.gray)
                                .cornerRadius(20)
                        }
                    }
                }
                
                Spacer()
                
                Image(systemName: moreOrLess[index]).onTapGesture{
                    scrollers.toggle()
                    index = (index + 1) % 2
                }
            }
        }
    }
}
