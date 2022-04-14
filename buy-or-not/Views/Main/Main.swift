//
//  Main.swift
//  buy-or-not
//
//  Created by leejunmo on 2022/04/06.
//
// 메인페이지입니다.
import SwiftUI



struct Main: View {  // 아울렛 변수
    // 사용자가 선택한 카테고리 값이 choose에 저장됨.
    @State private var choose = "모두보기"
    
    @State var data = QuestionItemManager()
    @State var user = UserDataManager()
    @State var previewImg: String = "default"
    @State var previewState: Bool = false
    
    @State var fromWhere: Bool = false
    
    @State var voteDone: Bool = false
    
    func CategorizedData() -> [QuestionItemData] {
        let info = ["패션/뷰티": "tshirt", "가구/인테리어": "bed.double", "식품/외식": "fork.knife", "전자제품": "desktopcomputer", "취미/여가": "gamecontroller", "기타": "ellipsis.circle"]
        
        var categorizedData: [QuestionItemData] = []
        
        if choose == "모두보기" {
            categorizedData = self.data.json
        } else if choose == "관심분야" {
            // 유저 한면 샘플
            for userFavorite in self.user.json[0].favorites {
                for feed in self.data.json {
                    if feed.category == userFavorite {
                        categorizedData.append(feed)
                    }
                }
            }
        } else {
            for feed in self.data.json {
                if feed.category == info[choose] {
                    categorizedData.append(feed)
                }
            }
        }
        return categorizedData
    }
    
    var body: some View {
        GeometryReader () {geometryReader in
            ZStack {
                NavigationView  {
                    ZStack {
                        VStack {
                            Spacer()
                            
                            MainCategory(choose: $choose)
                                .padding(.leading, 7.0)
                                .padding(.trailing, 17.0)
                                .padding(.bottom, 0)
                            //
                            // 피드 영역
                            ScrollView {
                                PullToRefresh(coordinateSpaceName: "pullToRefresh") {
                                    data.load(jsonName: "BethevSampleJSON") // 새로고침
                                }
                                // 피드 컨텐츠 영역
                                LazyVStack {
                                    let fixedData = CategorizedData()
                                    ForEach(0..<fixedData.count, id: \.self) { num in
                                        let feed = fixedData[num]
                                        let passedTime = (DateCalculator(originatedDate:feed.timeStamp).dateDiff.day! > 1) ? DateCalculator(originatedDate:feed.timeStamp).dateDiff.day! : DateCalculator(originatedDate:feed.timeStamp).dateDiff.hour!

//                                      var timeStemp = "default"
                                        
                                        QuestionItem(author: feed.author, title: feed.title, category: feed.category, items: feed.items, timestamp: passedTime, previewImg: $previewImg, previewState: $previewState, fromWhere: $fromWhere)
                                        //여기까지 송쿨꺼 입력
                                        .onAppear{
                                            // 임시
                                            if feed.title == "레이싱 휠 살까요 말까요" && choose == "모두보기" {
                                                data.reLoad(jsonName: "BethevSampleJSON") // 데이터 추가 로드
                                            }
                                        }
                                    }
                                }
                            }.padding(.horizontal, 17.0)
                        }.coordinateSpace(name: "pullToRefresh")
                        //
                        NavigationLink(destination: QuestionContentView(jsonData: $data) // 질문 남기기 뷰로 연결
                        ) {
                            ZStack {
                                Circle()
                                    .frame(width: 64.0)
                                    .foregroundColor(Color(hex: "8A67E8"))
                                Image(systemName: "square.and.pencil")
                                    .foregroundColor(Color.white)
                                    .font(.system(size: 24.0, weight: .regular))
                            }
                            .frame(width: 64.0, height: 64.0)
                        }
                        .position(x: geometryReader.size.width - 72.0, y: geometryReader.size.height - 72.0)
                        
                    }
                    .navigationBarItems(
                        leading: NavigationLink(
                            destination: signOutContentView(data: $data, user: $user)  // 프로필 뷰로 연결
                        ){
                            Image("profile")
                                .resizable()
                                .frame(width:38,height:38)
                                .aspectRatio(contentMode: .fit)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color(hex: "979797"),lineWidth: 1))
                        }
                        , trailing: NavigationLink(
                            destination: Search() // 검색 뷰로 연결
                        ){
                            Image(systemName: "magnifyingglass")
                                .font(.system(size: 24.0, weight: .regular))
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
}

struct Main_Previews: PreviewProvider {
    static var previews: some View {
        Main()
    }
}
