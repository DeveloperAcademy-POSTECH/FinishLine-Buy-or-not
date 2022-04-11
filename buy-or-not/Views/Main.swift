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
        GeometryReader { geometryReader in
            NavigationView  {
                ZStack {
                    VStack {
                        Spacer()
                        
                        MainCategorys()
                        
                        //
                        // 피드 영역
                        ScrollView {
                            PullToRefresh(coordinateSpaceName: "pullToRefresh") {
                                // 리프레쉬 코드 입력 공간 (서버 재연결)
                            }
                            // 피드 컨텐츠 영역
                            LazyVStack {
                                ForEach(data.json) { feed in
                                    QuestionItem(title: feed.title, author: feed.author, votes: feed.votes, comments: feed.comments, imageURL: feed.imageURL, options: feed.options)
                                }
                            }
                        }// 여기서 리로딩 콜백코드 구현해야함
                        //
                    }.coordinateSpace(name: "pullToRefresh")
                    //
                    //글쓰기버튼
                    NavigationLink(
                        destination: Question() // 질문 남기기 뷰로 연결
                    )
                    {
                        ZStack() {
                            Circle()
                                .frame(width: 64.0)
                                .foregroundColor(Color(hex: "8A67E8"))
                            
                            Image(systemName: "square.and.pencil")
                                .foregroundColor(Color.white)
                                .font(.system(size: 24.0, weight: .regular))
                        }
                    }
                    .frame(width: 64.0, height: 64.0)
                    .position(x: geometryReader.size.width - 0.0, y: geometryReader.size.height - 72.0)
                    
                }
                .padding(.horizontal, 17.0)
                .navigationBarItems(
                    leading: NavigationLink(
                        destination: Profile() // 프로필 뷰로 연결
                    ){
                        Image("sampleMan").font(.largeTitle)
                    }
                    , trailing: NavigationLink(
                        destination: Search() // 검색 뷰로 연결
                    ){
                        Image(systemName: "magnifyingglass")
                            .font(.system(size: 24.0, weight: .regular))
                            .foregroundColor(Color(hex: "8A67E8"))
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

struct QuestionItem: View {
    
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
                VoteButtonView(data: options)
            }.frame(height: 40)
            Spacer()
        }
        .frame(height: 177.5)
        Divider()
    }
}


struct VoteButtonView: View {
    
    var data: [Options]
    // 옵션 최대 갯수 4개
    @State var buttonState: [Bool] = [false, false, false, false]
    @State var voteDone: Bool = false
    
    
    func buttonTab(index: Int, dataCount: Int) {
        
        //MARK: - 문제없음
        if buttonState[index] == true  {
            self.voteDone = true
        } else {
            // 토글
            for i in 0..<dataCount {
                if (i == index) {
                    self.buttonState[i] = true
                } else {
                    self.buttonState[i] = false
                }
            }
        }
    }
    
    var body: some View {
        if voteDone {
            ZStack (alignment:.leading) {
                RoundedRectangle(cornerRadius: 10).frame(height: 40).foregroundColor(Color.init(hex: "F2F2F7"))
                RoundedRectangle(cornerRadius: 10).frame(width: 300, height: 40).foregroundColor(Color.init(hex: "C7C7CC"))
                RoundedRectangle(cornerRadius: 10).frame(width: 250, height: 40).foregroundColor(Color.init(hex: "8A67E8"))
                // 투표 현황 텍스트 추가되어야함
            }
        } else {
            HStack {
                ForEach (0..<data.count, id: \.self) { idx in
                    Button {
                        withAnimation {
                            buttonTab(index: idx, dataCount: data.count)
                        }
                    } label: {
                        ZStack {
                            Rectangle().foregroundColor(buttonState[idx] ? Color(hex: "DCA3FF") : .clear).cornerRadius(10)
                            Text(buttonState[idx] ? "한번 더 누르시면\n투표가 반영됩니다." : "\(idx + 1)번").foregroundColor(.black)
                                .font(buttonState[idx] ? .caption : .body)
                        }
                    }
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
