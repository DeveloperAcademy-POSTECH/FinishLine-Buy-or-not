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
        NavigationView  {
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
                            destination: Text("질문뷰") // 질문 남기기 뷰로 연결
                        ){
                            Image("questionButton").font(.largeTitle)
                        }
                    }
                }
            }
            .padding(.horizontal)
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
                    voteButtons(options: options)
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
    
    @State var options: [Options]
    
    @State var voteDone: Bool = false
    @State var buttonState: [Bool] = [false, false, false, false]
    
    var body: some View {
        if voteDone {
            ZStack (alignment:.leading) {
                RoundedRectangle(cornerRadius: 10).frame(height: 40).foregroundColor(Color.init(hex: "F2F2F7"))
                RoundedRectangle(cornerRadius: 10).frame(width: 300, height: 40).foregroundColor(Color.init(hex: "C7C7CC"))
                RoundedRectangle(cornerRadius: 10).frame(width: 250, height: 40).foregroundColor(Color.init(hex: "007AFF"))
                // 투표 현황 텍스트 추가되어야함
            }
        } else {
            switch options.count {
            case 1:
                Button(action: {
                    if buttonState[0] {withAnimation{voteDone = true}} else {buttonState[0].toggle()}
                }) {
                    ZStack {
                        Rectangle().foregroundColor(buttonState[0] ? .blue : .clear).cornerRadius(10)
                        Text(buttonState[0] ? "한번 더 누르시면\n투표가 반영됩니다." : "1번").foregroundColor(.black)
                            .font(buttonState[0] ? .caption : .body)
                    }
                }
            case 2:
                HStack {
                    Button(action: {
                        if buttonState[0] {withAnimation{voteDone = true}} else {buttonState[0].toggle()}
                        if buttonState[1] {buttonState[1].toggle()}
                    }) {
                        ZStack {
                            Rectangle().foregroundColor(buttonState[0] ? .blue : .clear).cornerRadius(10)
                            Text(buttonState[0] ? "한번 더 누르시면\n투표가 반영됩니다." : "1번").foregroundColor(.black)
                                .font(buttonState[0] ? .caption : .body)
                        }
                    }
                    Button(action: {
                        if buttonState[1] {withAnimation{voteDone = true}} else {buttonState[1].toggle()}
                        if buttonState[0] {buttonState[0].toggle()}
                    }) {
                        ZStack {
                            Rectangle().foregroundColor(buttonState[1] ? .blue : .clear).cornerRadius(10)
                            Text(buttonState[1] ? "한번 더 누르시면\n투표가 반영됩니다." : "2번").foregroundColor(.black)
                                .font(buttonState[1] ? .caption : .body)
                        }
                    }
                }
                
            case 3:
                Button(action: {
                    if buttonState[0] {withAnimation{voteDone = true}} else {buttonState[0].toggle()}
                    if buttonState[1] {buttonState[1].toggle()}
                    if buttonState[2] {buttonState[2].toggle()}
                }) {
                    ZStack {
                        Rectangle().foregroundColor(buttonState[0] ? .blue : .clear).cornerRadius(10)
                        Text(buttonState[0] ? "한번 더 누르시면\n투표가 반영됩니다." : "1번").foregroundColor(.black)
                            .font(buttonState[0] ? .caption : .body)
                    }
                }
                Button(action: {
                    if buttonState[1] {withAnimation{voteDone = true}} else {buttonState[1].toggle()}
                    if buttonState[0] {buttonState[0].toggle()}
                    if buttonState[2] {buttonState[2].toggle()}                }) {
                    ZStack {
                        Rectangle().foregroundColor(buttonState[1] ? .blue : .clear).cornerRadius(10)
                        Text(buttonState[1] ? "한번 더 누르시면\n투표가 반영됩니다." : "2번").foregroundColor(.black)
                            .font(buttonState[1] ? .caption : .body)
                    }
                }
                Button(action: {
                    if buttonState[2] {withAnimation{voteDone = true}} else {buttonState[2].toggle()}
                    if buttonState[1] {buttonState[1].toggle()}
                    if buttonState[0] {buttonState[0].toggle()}
                }) {
                    ZStack {
                        Rectangle().foregroundColor(buttonState[2] ? .blue : .clear).cornerRadius(10)
                        Text(buttonState[2] ? "한번 더 누르시면\n투표가 반영됩니다." : "3번").foregroundColor(.black)
                            .font(buttonState[2] ? .caption : .body)
                    }
                }
            case 4:
                Button(action: {
                    if buttonState[0] {withAnimation{voteDone = true}} else {buttonState[0].toggle()}
                    if buttonState[1] {buttonState[1].toggle()}
                    if buttonState[2] {buttonState[2].toggle()}
                    if buttonState[3] {buttonState[3].toggle()}
                }) {
                    ZStack {
                        Rectangle().foregroundColor(buttonState[0] ? .blue : .clear).cornerRadius(10)
                        Text(buttonState[0] ? "한번 더 누르시면\n투표가 반영됩니다." : "1번").foregroundColor(.black)
                            .font(buttonState[0] ? .caption : .body)
                    }
                }
                Button(action: {
                    if buttonState[1] {withAnimation{voteDone = true}} else {buttonState[1].toggle()}
                    if buttonState[0] {buttonState[0].toggle()}
                    if buttonState[2] {buttonState[2].toggle()}
                    if buttonState[3] {buttonState[3].toggle()}
                }) {
                    ZStack {
                        Rectangle().foregroundColor(buttonState[1] ? .blue : .clear).cornerRadius(10)
                        Text(buttonState[1] ? "한번 더 누르시면\n투표가 반영됩니다." : "2번").foregroundColor(.black)
                            .font(buttonState[1] ? .caption : .body)
                    }
                }
                Button(action: {
                    if buttonState[2] {withAnimation{voteDone = true}} else {buttonState[2].toggle()}
                    if buttonState[1] {buttonState[1].toggle()}
                    if buttonState[0] {buttonState[0].toggle()}
                    if buttonState[3] {buttonState[3].toggle()}
                }) {
                    ZStack {
                        Rectangle().foregroundColor(buttonState[2] ? .blue : .clear).cornerRadius(10)
                        Text(buttonState[2] ? "한번 더 누르시면\n투표가 반영됩니다." : "3번").foregroundColor(.black)
                            .font(buttonState[2] ? .caption : .body)
                    }
                }
                Button(action: {
                    if buttonState[3] {withAnimation{voteDone = true}} else {buttonState[3].toggle()}
                    if buttonState[1] {buttonState[1].toggle()}
                    if buttonState[2] {buttonState[2].toggle()}
                    if buttonState[0] {buttonState[0].toggle()}
                }) {
                    ZStack {
                        Rectangle().foregroundColor(buttonState[3] ? .blue : .clear).cornerRadius(10)
                        Text(buttonState[3] ? "한번 더 누르시면\n투표가 반영됩니다." : "4번").foregroundColor(.black)
                            .font(buttonState[3] ? .caption : .body)
                    }
                }
            default:
                Text("버튼 최대갯수 초과")
            }
        }
    }
}

struct Main_Previews: PreviewProvider {
    static var previews: some View {
        Main()
    }
}
