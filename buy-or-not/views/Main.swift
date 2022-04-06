//
//  Main.swift
//  buy-or-not
//
//  Created by leejunmo on 2022/04/06.
//
// 메인페이지입니다.

import SwiftUI

struct Main: View {
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    // 카테고리 코드 영역
                    Text("카테고리 자리")
                    //
                    ScrollView {
                        ForEach (1..<100) { idx in
                            Text("test \(idx)")
                        }
                    }
                    Spacer()
                    HStack {
                        Spacer()
                        NavigationLink(
                            destination: Search() // 질문 남기기 뷰로 연결(임시로 검색화면)
                        ){
                            Image("questionButton")
                        }
                    }
                }
            }.padding()
                .navigationBarItems(
                    leading: NavigationLink(
                        destination: Search() // 프로필 뷰로 연결(임시로 검색화면)
                    ){
                        Image("sampleMan").font(.largeTitle)
                    }
                    , trailing: NavigationLink(
                        destination: Search() // 검색 뷰로 연결
                    ){
                        Image(systemName: "magnifyingglass").font(.title)
                    }
                )
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Image("mainLogo")
                    }
                }
        }
    }
}

struct Main_Previews: PreviewProvider {
    static var previews: some View {
        Main()
    }
}
