//
//  UserView.swift
//  buy-or-not
//
//  Created by Noah's Ark on 2022/04/08.
//

import SwiftUI

// 이번 샘플 자료는..

// UserJSON 파일을 decoding 한 후 해당 데이터를 UserData의 형식에 맞게 저장합니다.
// 저장하는 방법은 UserManager의 로직을 따릅니다.
// 이후 UserManager의 내용은 아래의 코드와 같은 형식으로 화면에 표시 됩니다.

// 다음 순서로 파일을 확인하세요.
// UserData -> UserManager -> UserView

// json 파일 안에는 주석을 작성할 수가 없습니다... UserData 파일 내 UserJSON 설명을 함께 기재하겠습니다.
// 틀린 부분이 있다면 수정해주세요.

// 2022-04-08 Theo

struct UserView: View {
    
    
    // userData에 UserManager를 할당합니다.
    // UserManager는 내부 로직을 통해 UserJSON 데이터를 소지하고 있습니다.
    var userData = UserManager()

    var body: some View {
        NavigationView {
            VStack {
                Text("사용자 샘플 테스트 중입니다. 테오")
                    .padding()

                NavigationLink( destination: Search() ) {
                    VStack {
                        Image("questionButton").font(.largeTitle)
                        Text("탈출 버튼")
                    }
                }
                
                //🔥 UserManager의 내부 로직 실행 결과 userData 내부에 존재하는 json 변수는 UserJSON의 데이터를 가지고 있습니다.
                ForEach (userData.json) {data in
                    VStack {
                        HStack {
                            AsyncImage(url: URL(string: data.imageURL))
                                .frame(width: 110, height: 110)
                                .cornerRadius(8)
                            VStack {
                                Text(data.email)
                                Text(data.nickName)
                            }
                        }
                        HStack{
                            ForEach(data.favorites, id: \.self) {favorite in
                               
                                ZStack (alignment: .bottomTrailing) {
                                    if favorite.checked {
                                        Image(systemName: favorite.category)
                                            .resizable()
                                            .frame(width: 30, height: 30)
                                            .padding(.horizontal, 10)
                                        
                                        if favorite.awarded {
                                            Image(systemName: "heart.fill")
                                                .resizable()
                                                .frame(width: 15, height: 15)
                                                .foregroundColor(.red)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

//struct UserView_Previews: PreviewProvider {
//    static var previews: some View {
//        UserView()
//    }
//}
