//
//  Main.swift
//  buy-or-not
//
//  Created by leejunmo on 2022/04/06.
//
// 메인페이지입니다.

import SwiftUI
import Darwin

struct MainCategory: View{
    let mainCategorys: [String] = [
        "모두보기", "관심분야", "패션/뷰티", "가구/인테리어", "식품/외식", "전자제품", "취미/여가", "기타"]
     var moreOrLess = ["chevron.down", "chevron.up"]

    
    // 접기 펼치기 기능 관련 변수
    @State var scrollers: Bool = true
    @State var index = 0
    
    // 사용자가 선택한 카테고리 -> Main에서도 볼 수 있도록 Binding
    @Binding var choose: String
   
    
    var body: some View{
        HStack(alignment: .top){
            if scrollers{
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(alignment:.top ){
                        ForEach(mainCategorys, id: \.self){ c in
                            Button() {
                                choose = c
                            }label: {
                                Text(c)
                                    .font(.system(size:11,weight: .regular))
         
                                
                            }
                            .foregroundColor(self.choose == c ? Color.white: Color(hex: "636366"))
                            .frame( height: 23, alignment: .center)
                            .background(self.choose == c ? Color(hex: "8A67E8") : Color(hex: "D8D8D8"))
                            .cornerRadius(20)
                            .padding(.leading, c == "모두보기" ? 10 : 0)
                            .padding(.trailing, c == "기타" ? 4 : 0)
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
            } else{
                GeometryReader { geometry in
                    VStack(alignment: .leading) {
                        WrappedLayout(choiced: self.$choose, platforms: mainCategorys, geometry: geometry)
                    }
                }
                .frame(height: (index==1) ? 46.0 : 13.0)
            }
            Spacer()
            Button() {
                scrollers.toggle()
                index = (index + 1) % 2
            }label: {
                Image(systemName: moreOrLess[index])                        .font(.system(size:11,weight: .regular))
                
            }
            .foregroundColor(Color(hex: "636366"))
            .frame( height: 23, alignment: .center)
            .background(Color(hex: "D8D8D8"))
            .buttonStyle(.bordered)
            .cornerRadius(20)
            
        }
        .padding(.top, 8.0)
        .padding(.bottom, 6.0)
    }
}


struct WrappedLayout: View {
    @Binding var choiced: String
    let platforms: [String]
    let geometry: GeometryProxy
    
    
    var body: some View {
        self.generateContent(in: geometry)
    }
    
    private func generateContent(in g: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero
        
        return ZStack(alignment: .topLeading) {
            ForEach(self.platforms, id: \.self) { platform in
                Button() {
                    choiced = platform
                    // 접히기
                }label: {
                    Text(platform)
                        .font(.system(size:11, weight: .regular))
                }
                .foregroundColor(self.choiced == platform ? Color.white: Color(hex: "636366"))
                .frame( height: 23, alignment: .center)
                .background(self.choiced == platform ? Color(hex: "8A67E8") : Color(hex: "D8D8D8"))
                .cornerRadius(20)
                .padding(.leading,8)
                //.padding(.leading, platform == "모두보기" ? 10 : 0)
                //.padding(.trailing, platform == "기타" ? 4 : 0)
                .buttonStyle(.bordered)
                .alignmentGuide(.leading, computeValue: { d in
                    if (abs(width - d.width) > g.size.width)
                    {
                        width = 0
                        height -= d.height + 10
                    }
                    
                    let result = width
                    if platform == self.platforms.first! {
                        width = 0 //last item
                    } else {
                        width -= d.width
                    }
                    return result
                })
                .alignmentGuide(.top, computeValue: {d in
                    let result = height
                    if platform == self.platforms.first! {
                        height = 0 // last item
                    }
                    return result
                })
            }
        }
    }
    

  func item(for text: String) -> some View {
        Text(text)
            .padding(.all, 5)
            .font(.body)
            .background(Color.blue)
            .foregroundColor(Color.white)
            .cornerRadius(5)
    }

}
