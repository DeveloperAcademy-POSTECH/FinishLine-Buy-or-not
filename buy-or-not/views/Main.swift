//
//  Main.swift
//  buy-or-not
//
//  Created by leejunmo on 2022/04/06.
//
// 메인페이지입니다.

import SwiftUI

struct Main: View {
    
    @State var data = QuestionItemManager()
    
    var body: some View {
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
                            ForEach(data.json) { feed in
                                questionItem(title: feed.title, author: feed.author, votes: feed.votes, comments: feed.comments, imageURL: feed.imageURL, options: feed.options)
                            }
                        }
                    }// 여기서 리로딩 콜백코드 구현해야함
                    //
                }.coordinateSpace(name: "pullToRefresh")
                //
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        NavigationLink(
                            destination: Text("질문뷰") // 질문 남기기 뷰로 연결 (임시로 검색화면)
                        ){
                            Image("questionButton").font(.largeTitle)
                        }
                    }
                }
            }.padding(.horizontal)
                .navigationBarItems(
                    leading: NavigationLink(
                        destination: Text("프로필뷰")  // 프로필 뷰로 연결 (임시로 검색화면)
                    ){
                        Image("sampleMan").font(.largeTitle)
                    }
                    , trailing: NavigationLink(
                        destination: Text("검색뷰")  // 검색 뷰로 연결
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
    
    var title: String
    var author: String
    var votes: Int
    var comments: Int
    var imageURL: String
    var options: [Options]
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                AsyncImage(url: URL(string: imageURL))
                    .frame(width: 116, height: 116)
                    .cornerRadius(20)
                    .padding(.leading, 10)
                
                Spacer()
                
                VStack {
                    HStack {
                        Text("상세문구 테스트입니다.")
                            .font(.title3)
                        Spacer()
                    }
                    
                    Spacer()
                    
                    HStack {
                        Text(author)
                            .font(.caption)
                            .foregroundColor(.gray)
                        
                        Spacer()
                        
                        Text (
                            "\(Image(systemName: "checkmark.square"))\(votes) \(Image(systemName: "text.bubble"))\(comments)"
                        )
                        .font(.caption)
                        .foregroundColor(.gray)
                    }
                }
            }
            
            ZStack {
                RoundedRectangle(cornerRadius: 10).frame(height: 40).foregroundColor(Color.init(hex: "F2F2F7"))
                HStack {
                    voteButtons()
                }
            }.frame(height: 40)
            Spacer()
        }
        .frame(height: 177.5)
        Divider()
    }
}

// 다중 버튼을 하기위해서 스테이트 변수를 컨트롤할 수 있는 다른 구조를 만들어야함
struct voteButtons: View {
    @State private var buttonIsPressed1: Bool = false
    @State private var buttonIsPressed2: Bool = false
    @State private var buttonIsPressed3: Bool = false
    
    @State var voteDone: Bool = false
    
    var body: some View {
        if voteDone {
            ZStack (alignment:.leading) {
                RoundedRectangle(cornerRadius: 10).frame(height: 40).foregroundColor(Color.init(hex: "F2F2F7"))
                RoundedRectangle(cornerRadius: 10).frame(width: 300, height: 40).foregroundColor(Color.init(hex: "C7C7CC"))
                RoundedRectangle(cornerRadius: 10).frame(width: 250, height: 40).foregroundColor(Color.init(hex: "007AFF"))
                // 투표 현황 텍스트 추가되어야함
            }
        } else {
            Button(action: {
                if buttonIsPressed1 {withAnimation{voteDone = true}} else {buttonIsPressed1.toggle()}
                if buttonIsPressed2 {buttonIsPressed2.toggle()}
                if buttonIsPressed3 {buttonIsPressed3.toggle()}
            }) {
                ZStack {
                    Rectangle().foregroundColor(buttonIsPressed1 ? .blue : .clear).cornerRadius(10)
                    Text(buttonIsPressed1 ? "한번 더 누르시면\n투표가 반영됩니다." : "1번").foregroundColor(.black)
                        .font(buttonIsPressed1 ? .caption : .body)
                }
            }
            Button(action: {
                if buttonIsPressed2 {withAnimation{voteDone = true}} else {buttonIsPressed2.toggle()}
                if buttonIsPressed1 {buttonIsPressed1.toggle()}
                if buttonIsPressed3 {buttonIsPressed3.toggle()}
            }) {
                ZStack {
                    Rectangle().foregroundColor(buttonIsPressed2 ? .blue : .clear).cornerRadius(10)
                    Text(buttonIsPressed2 ? "한번 더 누르시면\n투표가 반영됩니다." : "2번").foregroundColor(.black)
                        .font(buttonIsPressed2 ? .caption : .body)
                }
            }
            Button(action: {
                if buttonIsPressed3 {withAnimation{voteDone = true}} else {buttonIsPressed3.toggle()}
                if buttonIsPressed2 {buttonIsPressed2.toggle()}
                if buttonIsPressed1 {buttonIsPressed1.toggle()}
            }) {
                ZStack {
                    Rectangle().foregroundColor(buttonIsPressed3 ? .blue : .clear).cornerRadius(10)
                    Text(buttonIsPressed3 ? "한번 더 누르시면\n투표가 반영됩니다." : "3번").foregroundColor(.black)
                        .font(buttonIsPressed3 ? .caption : .body)
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
