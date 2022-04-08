//
//  Main.swift
//  buy-or-not
//
//  Created by leejunmo on 2022/04/06.
//
// 메인페이지입니다.

import SwiftUI

struct Main: View {
    @State private var maxNumber: Int = 9
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    Spacer()
                    // 카테고리 코드 영역
                    
                    Text("카테고리 자리")
                    
                    //
                    // 피드 영역
                    ScrollView {
                        PullToRefresh(coordinateSpaceName: "pullToRefresh") {
                            // 리프레쉬 코드 입력 공간 (서버 재연결)
                        }
                        // 피드 컨텐츠 영역
                        LazyVStack {
                            ForEach(0...maxNumber, id: \.self) { num in
                                    questionItem(number: num) // 컨텐츠표시
                                    .onAppear {
                                      if num % 10 == 9 {
                                        maxNumber += 10 // 추가로딩
                                    }
                                }
                            }
                        }
                        //
                    }.coordinateSpace(name: "pullToRefresh")
                    //
                }
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        NavigationLink(
                            destination: Question() // 질문 남기기 뷰로 연결 (임시로 검색화면)
                        ){
                            Image("questionButton").font(.largeTitle)
                        }
                        
                    }
                }
            }.padding(.horizontal)
                .navigationBarItems(
                    leading: NavigationLink(
                        destination: Search() // 프로필 뷰로 연결 (임시로 검색화면)
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

struct PullToRefresh: View {
    
    var coordinateSpaceName: String
    var onRefresh: ()->Void
    
    @State var needRefresh: Bool = false
    
    var body: some View {
        GeometryReader { geo in
            if (geo.frame(in: .named(coordinateSpaceName)).midY > 45) {
                Spacer()
                    .onAppear {
                        needRefresh = true
                    }
            } else if (geo.frame(in: .named(coordinateSpaceName)).maxY < 10) {
                Spacer()
                    .onAppear {
                        if needRefresh {
                            needRefresh = false
                            onRefresh()
                        }
                    }
            }
            HStack {
                Spacer()
                if needRefresh {
                    ProgressView()
                } else {
                    Image(systemName: "arrow.triangle.2.circlepath") // 리프레쉬 이미지 적용
                }
                Spacer()
            }
        }.padding(.top, -50)
    }
}

struct questionItem: View {
    let number: Int

    var body: some View {
      VStack {
          Spacer()
          HStack {
              Image(systemName: "p.square.fill").resizable().frame(width: 116, height: 116).foregroundColor(.gray)
              Spacer()
              VStack {
                  HStack {
                      Text("어디어디 제품이고\n가격이 얼마인데 살지 말지 고민이 되네요..").font(.title3)
                      Spacer()
                  }
                  Spacer()
                  HStack {
                      Text("bethev").font(.caption).foregroundColor(.gray)
                      Spacer()
                      Text("\(Image(systemName: "checkmark.square"))16 \(Image(systemName: "text.bubble"))21").font(.caption).foregroundColor(.gray)
                  }
              }
          }
          Spacer()
          RoundedRectangle(cornerRadius: 10).foregroundColor(.blue).frame(height: 42)
          Spacer()
      }
      .frame(height: 177.5)
        Divider()
    }
  }

struct Main_Previews: PreviewProvider {
    static var previews: some View {
        Main()
    }
}
