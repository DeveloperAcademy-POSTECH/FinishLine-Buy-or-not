//
//  SwiftUIView.swift
//  buy-or-not
//
//  Created by 송시원 on 2022/04/07.
//

import SwiftUI

struct SwiftUIView: View {
    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    VStack {
                        VStack {
                            Text("제목 입력구간")
                            HStack {
                                HStack {
                                    Text("아이디")
                                }
                                Text("날짜")
                            }
                            
                        }
                        Text("고민작성부분")
                    }
                    VStack {
                        HStack {
                            RoundedRectangle(cornerRadius: /*@PLACEHOLDER=Corner Radius@*/8.0)
                                .frame(width: 310.0, height: 116.0)
                                
                            
                            Circle()
                                .frame(width: 36.0)
                                .foregroundColor(/*@START_MENU_TOKEN@*/Color.gray/*@END_MENU_TOKEN@*/)
                                
                        }
                    }
                }
            }
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
