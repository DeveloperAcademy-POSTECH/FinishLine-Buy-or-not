//
//  PostPage.swift
//  buy-or-not
//
//  Created by 송시원 on 2022/04/07.
//

import SwiftUI

var itemCount: Int = 3
var commentCounts: Int = 3


struct PostPage: View {
    @State var celectedIdx: Int = -1

    // 투표 데이터
    var arrName = ["첫번째 상품이름", "두번째 상품명", "세번째 상품블라블라"]
    var arrCost = ["11,000", "14,000", "4,900"]
    var arrOrder = [0,1,2]
    
    // 댓글 데이터
    
    // 투표수 데이터
    var itemSel01 = ["id01","id01","id01","id01"]
    
    
    var body: some View {
        ScrollView {
            VStack {
                questionContents()
                
                //투표선택영역
                VStack {
                    ForEach(arrOrder, id: \.self) { s in
                        selectionItem(selectedNum:self.$celectedIdx ,itmeOrder : s,isLast : false ,itmeName : arrName[s] ,itemCost : arrCost[s] ,itemURL : "https://www.google.com")
                    }
                    

                    
                    selectionItem(selectedNum:self.$celectedIdx, itmeOrder : arrOrder.count , isLast : true,itmeName : "추천하지 않습니다! 다른 제품은 어때요?" ,itemCost : " " ,itemURL : "0")

                }
                .padding(.top, 30.0)
                .padding([.leading, .trailing],15)
                .padding(.bottom, 30.0)
                .background(Color(hex: "#E9E9EA"))
                .frame(minWidth:0, maxWidth: .infinity)
            }
        }// scroll view
        .frame(maxWidth: .infinity)
        .navigationTitle("질문보기")

        
    }
}




// 컬러를 따로 설정하는 방식
extension Color {
    static let cyon = Color(red: 26 / 255, green: 232 / 255, blue: 212 / 255)
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
        Spacer()
            .frame(height: 24)
    }
}

// 투표아이템
struct selectionItem: View {
    //몇개인지 확인한다.
    
    @Binding var selectedNum: Int
    let itmeOrder: Int
    let isLast: Bool
    let itmeName: String
    let itemCost: String
    let itemURL: String
    
    //@State 값의 변화를 감지 -> 뷰에 적용
    @State var isActivated:Bool = false
    
    var body: some View {
        HStack{
            ZStack {
                RoundedRectangle(cornerRadius:8.0)
                    .fill(selectedNum == itmeOrder ? Color.blue : Color.white)
                    .onTapGesture {
                        selectedNum = itmeOrder
                        //선택영역 안에 또 선택할 수 있기 때문에 여기에 둠.
                    }
                //스트로크
                RoundedRectangle(cornerRadius:8.0)
                    .strokeBorder(lineWidth: 1)
                
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
                        Text(itmeName)
                            .font(.system(size: 18, weight: .bold))
                            .padding(.top, 2.0)
                            .frame(minWidth:0,maxWidth: 187, alignment: .leading)
                        Spacer()
                        
                        HStack{
                            // 가격
                            Text(itemCost)
                                .foregroundColor(.gray)
                            Spacer()
                            if !isLast {
                                LinkURL( url: itemURL)
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
                    .strokeBorder(lineWidth: 1)
                Text(String(itmeOrder+1))
                
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
