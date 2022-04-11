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
                                    .background(self.choiced == c ? Color(hex: "8A67E8") : Color.gray)
                                    .cornerRadius(20)
                                    .padding(.vertical, 24.0)
                                    .padding(.leading, c == "모두보기" ? 10 : 0)
                                    .padding(.trailing, c == "기타" ? 10 : 0)
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
                               .frame(width: 10)

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
                                .background(self.choiced == c ? Color(hex: "8A67E8") : Color.gray)
                                .cornerRadius(20)
                        }
                    }
                }
                
                Spacer()
                
                Image(systemName: moreOrLess[index]).onTapGesture{
                    scrollers.toggle()
                    index = (index + 1) % 2
                    print(index)
                }
                    .foregroundColor(Color(hex: "8A67E8"))
                    .font(.system(size: 24, weight: .regular))

            }
        }
    }
}
