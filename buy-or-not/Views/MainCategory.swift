//
//  Main.swift
//  buy-or-not
//
//  Created by leejunmo on 2022/04/06.
//
// 메인페이지입니다.

import SwiftUI

struct MainCategory: View{
    let categories: [String] = [
        "모두보기", "for you", "패션/뷰티", "가구/인테리어", "식품/외식", "전자제품", "취미/여가", "기타"]
    
    // 접기 펼치기 기능 관련 변수
    var moreOrLess = ["chevron.down", "chevron.up"]
    @State var scrollers: Bool = true
    @State var index = 0
    
    // 사용자가 선택한 카테고리 -> Main에서도 볼 수 있도록 Binding
    @Binding var choose: String
   
    
    var body: some View{
        ZStack{
            HStack{
                // 카테고리를 접지 않은 경우
                if scrollers{
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack{
                            ForEach(categories, id: \.self){ category in
                                Button(category) {
                                    choose = category
                                }.foregroundColor(.white)
                                    .frame( height: 30, alignment: .center)
                                    .background(self.choose == category ? Color(hex: "8A67E8") : Color.gray)
                                    .cornerRadius(20)
                                    .padding(.vertical, 24.0)
                                    .padding(.leading, category == "모두보기" ? 10 : 0)
                                    .padding(.trailing, category == "기타" ? 10 : 0)
                                    .buttonStyle(.bordered)
                            }
                        }
                    }
                    
                    // 좌우 스크롤 그라데이션
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
                
                // 좌우 스크롤이 아닐 때
                else{
                    let gridItems = [GridItem(.fixed(100)),
                                     GridItem(.fixed(100)),
                                     GridItem(.fixed(100))]
                    
                    LazyVGrid(columns: gridItems){
                        ForEach(categories, id: \.self){ category in Button(category) {
                            choose = category
                        }.foregroundColor(.white)
                                .frame(width:100, height: 30, alignment: .center)
                                .background(self.choose == category ? Color(hex: "8A67E8") : Color.gray)
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
