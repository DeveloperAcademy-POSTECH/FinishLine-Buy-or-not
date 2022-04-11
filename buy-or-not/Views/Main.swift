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

// From Theo to Halogen : 테스트 몇 번 해볼게요 
//         GeometryReader { geometryReader in

        if previewState {
            ZStack {
                Rectangle().fill(Color.black)
                    .frame(width: .infinity, height: .infinity)
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
            }
            .background(Color.white)
            .cornerRadius(5)
            .shadow(radius: 5)
            .onTapGesture {
                previewState.toggle()
            }
        } else {

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
                          
// @Bethev, @Songcool, @Halogen
// Need to confirm below codes                        
// 글쓰기버튼                          
//                     NavigationLink(
//                         destination: Question() // 질문 남기기 뷰로 연결
//                     )
//                     {
//                         ZStack() {
//                             Circle()
//                                 .frame(width: 64.0)
//                                 .foregroundColor(Color(hex: "8A67E8"))
                            
//                             Image(systemName: "square.and.pencil")
//                                 .foregroundColor(Color.white)
//                                 .font(.system(size: 24.0, weight: .regular))
                          
                          
                            // 피드 컨텐츠 영역
                            LazyVStack {
                                ForEach(data.json) { feed in
                                    QuestionItem(
                                      title: feed.title, 
                                      author: feed.author, 
                                      votes: feed.votes, 
                                      comments: feed.comments, 
                                      imageURL: feed.imageURL, 
                                      options: feed.options, 
                                      previewImg: $previewImg, 
                                      previewState: $previewState
                                    )
                                        .onAppear()//여기서 리로딩 콜백
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

    @Binding var previewImg: String
    @Binding var previewState: Bool
    
    @State private var mode: Int = 0
    
    var body: some View {
        VStack(alignment:.leading) {
            if (mode==0) {
                HStack {
                    AsyncImage(url: URL(string: imageURL))
                        .frame(width: 116, height: 116)
                        .cornerRadius(20)
                        .aspectRatio(contentMode: .fit)
                        .onTapGesture {
                            previewImg = imageURL
                            previewState.toggle()
                        }
                    Spacer()
                    
                    VStack(alignment:.leading) {
                        Text("질문작성 부분입니다.")
                            .font(.system(size: 18, weight: .regular))
                        Spacer()
                        HStack {
                            Text(author)
                                .lineLimit(1)
                            Spacer()
                            Text (
                                "12분 전   \(Image(systemName: "checkmark.square"))\(votes)"
                            )
                        }
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.gray)


                    }
                }
            } else{
                
                HStack {
                    AsyncImage(url: URL(string: imageURL))
                        .frame(width: 116, height: 116)
                        .cornerRadius(20)
                        .onTapGesture {
                            previewImg = imageURL //이부분을 수정해야함.
                            previewState.toggle()
                        }
                    Spacer()
                    
                    VStack(alignment:.leading) {
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
                            
                            if(Float.random(in: 0...1) < 0.5){ LinkURL( url: "https://www.naver.com") } else{ LinkURL( url: "options[mode-1]")
                            }
                        }
                        .font(.system(size: 18, weight: .bold))
                    }
                }
            }
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .frame(height: 40)
                    .foregroundColor(Color.init(hex: "F2F2F7"))
                VoteButtonView(data: options,mode_:self.$mode)
            }.frame(height: 40)
            Spacer()
                .frame(height: 17.0)
        }
        .frame(height: 177.5)
        Divider()
            .padding(.bottom, 17.0)
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
            mode_ = 0
            self.voteDone = true
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
                RoundedRectangle(cornerRadius: 10).frame(width: 250, height: 40).foregroundColor(Color.init(hex: "8A67E8"))
                // 투표 현황 텍스트 추가되어야함
            }
        } else {
            HStack {
                ForEach (0..<data.count, id: \.self) { idx in
                    Button {
                        withAnimation {
                            mode_ = idx + 1
                            buttonTab(index: idx, dataCount: data.count)
                        }
                    } label: {
                        ZStack {
                            Rectangle().foregroundColor(buttonState[idx] ? Color(hex: "DCA3FF") : .clear).cornerRadius(10)
                            Text(buttonState[idx] ? "투표하기" : data[idx].name)
                                .foregroundColor(buttonState[idx] ? Color.white :Color.black)
                                .font(.body)

                        }
                    }
                }
            }
        }
    }
}

struct LinkURL: View {
    @Environment(\.openURL) private var openURL

    let url: String

    var body: some View {
        Image(systemName: "link")
            .onTapGesture {
            if let url = URL(string: url) {
                openURL(url)
            }
        }
    }
}

struct Main_Previews: PreviewProvider {
    static var previews: some View {
        Main()
    }
}
