//
//  PostPage.swift
//  buy-or-not
//
//  Created by 송시원 on 2022/04/07.
//

import SwiftUI

var itemCount: Int = 3


struct PostPage: View {
    var body: some View {
        ScrollView {
            VStack {
                questionContents()
                
                //투표선택영역
                VStack {
                    selectionItem(itmeOrder : 1)
                    
                }
                .padding(.top, 30.0)
                .padding([.leading, .trailing],15)
                .padding(.bottom, 30.0)
                .background(Color.gray)
                .frame(minWidth:0, maxWidth: .infinity)
                
            }
            //            NavigationView {
            NavigationLink(destination: LoadingPage() ) {
                Text("제목이 작성됩니다.")
                    .font(.title)
                    .multilineTextAlignment(.leading)
            }
            //            }
        }// scroll view
        .frame(maxWidth: .infinity)
//        .background(Color.brown)
        //테스트용 bg
        
    }
}




// 컬러를 따로 설정하는 방식
extension Color {
    static let cyon = Color(red: 26 / 255, green: 232 / 255, blue: 212 / 255)
}

struct questionContents: View{
    var body: some View {
        //글 제목 영역
        HStack {
            Text("제목이 작성됩니다.")
                .font(.title)
                .multilineTextAlignment(.leading)
            Spacer()
        }
        HStack {
            Text("사용자 이름")
            Text("2022.04.07")
            Spacer()
        }
        // 질문내용 본문영역
        Text("본문의 질문들이 작성됩니다.")
            .font(.body)
            .multilineTextAlignment(.leading)
    }
}


// 수정하기
struct selectionItem: View {
    //몇개인지 확인한다.
    let itmeOrder: Int
    //@State 값의 변화를 감지 -> 뷰에 적용
    @State var isActivated:Bool = false
    
    var body: some View {
        HStack{
            ZStack {
                RoundedRectangle(cornerRadius:8.0)
                    .fill(isActivated ? Color.blue : Color.white)
                    .onTapGesture {
                        self.isActivated.toggle()
//선택영역 안에 또 선택할 수 있기 때문에 여기에 둠.
                    }
                //스트로크
                RoundedRectangle(cornerRadius:8.0)
                    .strokeBorder(Color(hex: "#E5E5EA"), lineWidth: 1)
                
                HStack{
                    //이미지영역
                    ZStack{
                        Rectangle()
                            .frame(width: 96, height:96)
                    }.onTapGesture {
                        //이미지 확대하기
                    }
                    
                    VStack{
                        //텍스트 작성
                        Text("상품 이름이 이렇게 작성됩니다.").font(.system(size: 18, weight: .bold)).padding(.top, 2.0).frame(width: 187)
                        Spacer()
                        
                        HStack{
                            // 가격
                            Text("11,900").foregroundColor(.gray)
                            Spacer()
                            // 링크 있다면 표시.
//                            Button("􀉣") {
//                                //외부 링크로 연결해줘야합니다.
//                            }
                            
                            Image(systemName: "link").onTapGesture {
                                //선택
                            }
                        }
                        .frame(width: 187)
                    }
                    .frame(width: 187)
                }
                .padding(.all, 10.0)
            }
            .frame(width: 310, height: 116.0)
            
            
            ZStack {
                Circle()
                    .fill(isActivated ? Color.blue : Color.white)
                    .onTapGesture {
                        self.isActivated.toggle()
//선택영역 안에 또 선택할 수 있기 때문에 여기에 둠.
                    }
                Circle()
                    .strokeBorder(Color(hex: "#E5E5EA"), lineWidth: 1)
                Text("1")
                
            }
            .frame(width: 36, height: 36)
        }
        
        
    }
}


struct PostPage_Previews: PreviewProvider {
    static var previews: some View {
        PostPage()
    }
}


