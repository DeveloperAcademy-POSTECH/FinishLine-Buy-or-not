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
    @State var previewImg: String = "defalt"
    @State var previewState: Bool = false
    
    var body: some View {
        ZStack {
            NavigationView  {
                ZStack {
                    VStack {
                        Spacer()

                        MainCategorys()
                        
                        //
                        // 피드 영역
                        ScrollView {
                            PullToRefresh(coordinateSpaceName: "pullToRefresh") {
                                data.load() // 새로고침
                            }
                            // 피드 컨텐츠 영역
                            LazyVStack {
                                ForEach(0..<data.json.count, id: \.self) { num in
                                    let feed = data.json[num]
                                    QuestionItem(title: feed.title, author: feed.author, votes: feed.votes, comments: feed.comments, imageURL: feed.imageURL, options: feed.options, previewImg: $previewImg, previewState: $previewState)
                                        .onAppear{
                                            if feed.votes == 50 {
                                                data.reLoad() // 데이터 추가 로드
                                            }
                                        }
                                }
                            }
                        }
                    }.coordinateSpace(name: "pullToRefresh")
                    //
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            NavigationLink(
                                destination: Question() // 질문 남기기 뷰로 연결
                            ){
                                Image("questionButton").font(.largeTitle)
                            }
                        }
                    }
                }
                .padding(.horizontal)
                .navigationBarItems(
                    leading: NavigationLink(
                        destination: Profile() // 프로필 뷰로 연결 (임시로 검색화면)
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
            if previewState {
                ZStack {
                    Rectangle().fill(Color.black).opacity(0.8)
                    AsyncImage(url: URL(string: previewImg)) { phase in
                                    switch phase {
                                    case .empty:
                                        ProgressView()
                                    case .success(let image):
                                        image.resizable()
                                             .aspectRatio(contentMode: .fit)
                                             .frame(maxWidth: .infinity)
                                    case .failure:
                                        Image(systemName: "photo")
                                    default:
                                        Text("오류")
                                    }
                    }.background(Color.white)
                }.onTapGesture {
                    previewState.toggle()
                }.edgesIgnoringSafeArea(.all)
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

    @Binding var previewImg: String
    @Binding var previewState: Bool
    
    @State private var mode: Int = 0
    
    var body: some View {
        VStack {
            if (mode==0) {
                HStack {
                    ZStack {
                        // 보더적용
                        RoundedRectangle(cornerRadius: 20)
                            .strokeBorder(lineWidth: 1)
                            .foregroundColor(.gray)
                            .frame(width: 116, height: 116)
                        
                        // 이미지 크기 보정 적용
                        AsyncImage(url: URL(string: imageURL)) { phase in
                                switch phase {
                                case .empty:
                                    Text("이미지 없음")
                                case .success(let image):
                                    image.resizable()
                                         .aspectRatio(contentMode: .fit)
                                         .frame(maxWidth: 116, maxHeight: 116)
                                case .failure:
                                    Image(systemName: "photo")
                                @unknown default:
                                    Text("이미지 없음")
                            }
                        }
                        .frame(width: 116, height: 116)
                        .cornerRadius(20)
                        .onTapGesture {
                            previewImg = imageURL
                            previewState.toggle()
                        }
                    }
                    Spacer()
                    
                    VStack {
                        HStack {
                            Text("질문작성 부분입니다.")
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
                                "\(Image(systemName: "checkmark.square"))\(votes)"
                            )
                            .font(.caption)
                            .foregroundColor(.gray)
                        }
                    }
                }
            } else{
                HStack {
                    ZStack {
                        // 보더적용
                        RoundedRectangle(cornerRadius: 20)
                            .strokeBorder(lineWidth: 1)
                            .foregroundColor(.gray)
                            .frame(width: 116, height: 116)
                        
                        // 이미지 크기 보정 적용
                        AsyncImage(url: URL(string: imageURL)) { phase in
                                switch phase {
                                case .empty:
                                    Text("이미지 없음")
                                case .success(let image):
                                    image.resizable()
                                         .aspectRatio(contentMode: .fit)
                                         .frame(maxWidth: 116, maxHeight: 116)
                                case .failure:
                                    Image(systemName: "photo")
                                @unknown default:
                                    Text("이미지 없음")
                            }
                        }
                        .frame(width: 116, height: 116)
                        .cornerRadius(20)
                        .onTapGesture {
                            previewImg = imageURL
                            previewState.toggle()
                        }
                    }
                    Spacer()
                    
                    VStack {
                        HStack {
                            Text(options[mode-1].name)
                                .font(.system(size: 18, weight: .regular))
                            Spacer()
                            Text (
                                "\(Image(systemName: "xmark"))"
                            )
                            .onTapGesture {
                                mode=0
                            }
                        }
                        
                        Spacer()
                        
                        HStack {
                            if( Float.random(in: 0...1) < 0.5 ){
                                Text("(opt[mode-1].cost)")
                                    .foregroundColor(.gray)
                                
                            } else {
                                Text("18,000")
                                    .foregroundColor(.gray)
                            }
                            
                            Spacer()
                            
                            Text (
                                "\(Image(systemName: "link"))"
                            )
                            .foregroundColor(.gray)
                        }
                        .font(.system(size: 18, weight: .bold))
                        
                    }
                }
            }
            ZStack {
                RoundedRectangle(cornerRadius: 10).frame(height: 40).foregroundColor(Color.init(hex: "F2F2F7"))
                VoteButtonView(data: options,mode_:self.$mode)
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
    
    @Binding var mode_:Int
    
    func buttonTab(index: Int, dataCount: Int) {
        
        //MARK: - 문제없음
        if buttonState[index] == true  {
            self.voteDone = true
            mode_ = 0
        } else {
            // 토글
            for i in 0..<dataCount {
                if (i == index) {
                    self.buttonState[i] = true
                    //i가 눌림,
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
                RoundedRectangle(cornerRadius: 10).frame(width: 250, height: 40).foregroundColor(Color.init(hex: "007AFF"))
                // 투표 현황 텍스트 추가되어야함
            }
        } else {
            HStack {
                ForEach (0..<data.count, id: \.self) { idx in
                    Button {
                        withAnimation {
                            buttonTab(index: idx, dataCount: data.count)
                            mode_ = idx + 1
                        }
                    } label: {
                        ZStack {
                            Rectangle().foregroundColor(buttonState[idx] ? .blue : .clear).cornerRadius(10)
                            Text(buttonState[idx] ? "투표하기" : data[idx].name)
                                .foregroundColor(.black)
                                .font(.body)
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
