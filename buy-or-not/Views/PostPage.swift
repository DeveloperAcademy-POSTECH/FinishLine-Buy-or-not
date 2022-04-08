//
//  PostPage.swift
//  buy-or-not
//
//  Created by 송시원 on 2022/04/07.
//
import SwiftUI
/*
 {
     "postId":"1"
     "tittle":"이거살래는데요.."
     "name": "John",
     "explaination": "이제품은 어떤가요?!",
     "options": {
         "option1":{
             "op-name":"이거",
             "op-cost":"23000",
             "op-imgroot":"./img/id/op1.jpg",
             "votes":{
                 "username01":{
                     "isComment" : true
                     "comment":"댓글내용",
                     "commentLike":["username02","username02","username02"]
                 },
             "username01":{
                 "isComment" : true
                 "comment":"댓글내용",
                 "commentLike":["username02","username02","username02"]
             },
             }
         },
         "option2":{
             "op-name":"이거",
             "op-cost":"23000",
             "op-imgroot":"./img/id/op1.jpg",
             "votes":{
                 "username01":{
                     "isComment" :
                     "comment":"댓글내용",
                     "commentLike":["username02","username02","username02"]
                 },
             }
         },
         "option3":{
             "op-name":"이거",
             "op-cost":"23000",
             "op-imgroot":"./img/id/op1.jpg",
             "votes":{
                 "username01":{
                     "isComment" :
                     "comment":"댓글내용",
                     "commentLike":["username02","username02","username02"]
                 },
             }
         },
     }//선택지와 관련된 내용.
 }
 */

var itemCount: Int = 3
var commentCounts: Int = 3


struct PostPage: View {
    var body: some View {
        ScrollView {
            VStack {
                questionContents()
                
                //투표선택영역
                VStack {
                    
                    selectionItem(itmeOrder : 1)
                    selectionItem(itmeOrder : 2)
                    
                }
                .padding(.top, 30.0)
                .padding([.leading, .trailing],15)
                .padding(.bottom, 30.0)
                .background(Color(hex: "#E9E9EA"))
                .frame(minWidth:0, maxWidth: .infinity)
                
                //댓글영역 시작
                
                
                //댓글 그룹
                VStack{
                    Spacer()
                        .frame(height: 30.0)
                    HStack{
                        Text("댓글"+String(commentCounts))
                        Spacer()
                    }
                    commentView()
                    commentView()
                    commentView()

                }
                .padding(.bottom, 30.0)
                .padding(.horizontal, 17.0)

            }
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



// 투표아이템
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
                    
                    VStack(alignment:.leading){
                        //텍스트 작성
                        Text("상품 이름이 이렇게 작성됩니다.")
                            .font(.system(size: 18, weight: .bold))
                            .padding(.top, 2.0)
                            .frame(minWidth:0,maxWidth: 187, alignment: .leading)
                        Spacer()
                        
                        HStack{
                            // 가격
                            Text("11,900")
                                .foregroundColor(.gray)
                            Spacer()
                            // 링크 있다면 표시.
                            //                            Button("􀉣") {
                            //                                //외부 링크로 연결해줘야합니다.
                            //                            }
                            
                            LinkURL()
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


// 댓글 서브뷰
struct commentView: View{
    var body: some View {
        HStack{
            VStack{
                //프로필 이미지 넣기
                ZStack {
                    Circle()
                        .fill( Color.blue)
                        .onTapGesture {
                            //사람을 선택하는부분
                        }
                    Circle()
                        .strokeBorder(Color(hex: "#E5E5EA"), lineWidth: 1)
                }
                .frame(width: 36, height: 36)
                Spacer()
            }
            //댓글화면 구성
            VStack{
                HStack{
                    Text("􀀻")
                        .multilineTextAlignment(.leading)
                    Text("dnrur124")
                        .multilineTextAlignment(.leading)
                    
                    Spacer()
                }
                
                Text("이거가 저거보다 훨 나아요. 저거는 품질이 좀 구려서 몇번 못써요.")
                    .multilineTextAlignment(.leading)
                HStack{
                    Text("2시간")
                        .multilineTextAlignment(.leading)
                    Text("좋아요 2개")
                        .multilineTextAlignment(.leading)
                    Text("답글달기")
                        .multilineTextAlignment(.leading)
                    Spacer()
                }
            }
            //좋아요 버튼
            Button("♥") {
                
            }
        }
    }
}


//질문작성
struct questionContents: View{
    var body: some View {
        
        VStack(alignment:.leading){
            //글 제목 영역
                Text("제목이 작성됩니다.")
                    .font(.title)
                    .multilineTextAlignment(.leading)
            
            HStack {
                Text("Theo")
                Text("2022.04.07")
                    .foregroundColor(.gray)
                Spacer()
            }
            .font(.system(size: 12, weight: .regular))
            // 질문내용 본문영역
            Text("본문의 질문들이 작성됩니다.")
                .font(.system(size: 16, weight: .regular))
                .multilineTextAlignment(.leading)
                .padding(.top, 10.0)
            
        }
        .padding(.horizontal, 17.0)
        
    }
}



struct LinkURL: View {
    @Environment(\.openURL) private var openURL

    var body: some View {
        Image(systemName: "link")
            .onTapGesture {
            if let url = URL(string: "https://developer.apple.com/documentation/swiftui/openurlaction") {
                openURL(url)
            }
        }
    }
}


struct PostPage_Previews: PreviewProvider {
    static var previews: some View {
        PostPage()
    }
}
