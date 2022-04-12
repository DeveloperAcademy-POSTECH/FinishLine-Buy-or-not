//
//  Profile.swift
//  buy-or-not
//
//  Created by Apple_Academy on 2022/04/08.
// Geometry 적용하기
// User 자기가 투표한 포스트의 ID를 가진다

import SwiftUI
import UIKit

struct VoteResults: View {
    
    var body: some View {
        VStack{
            Image(systemName:"exclamationmark.bubble.fill")
                .resizable(resizingMode: .stretch)
                .foregroundColor(Color.gray)
                .frame(width: 60.0, height: 60.0)
            Text("나의답변")
                .foregroundColor(Color.gray)
            ZStack (alignment:.leading) {
                RoundedRectangle(cornerRadius: 10).frame(height: 40).foregroundColor(Color.init(hex: "F2F2F7"))
                RoundedRectangle(cornerRadius: 10).frame(width: 300, height: 40).foregroundColor(Color.init(hex: "C7C7CC"))
                RoundedRectangle(cornerRadius: 10).frame(width: 250, height: 40).foregroundColor(Color.init(hex: "007AFF"))
                // 투표 현황 텍스트 추가되어야함
            }
            
        }
    }
}


struct Profile: View {
    @State var imageUrl: String = "profile"
    @State var nickName: String = "배고픈20대"
    @State var comment: String = "전자기기에 관심이 많은 20대 입니다."
    @State var interests: Array = ["tshirt","desktopcomputer","airtag"]
    
    var body: some View {
        NavigationView{
            VStack{
                HStack{
                    
                    Spacer()
                    
                    Text("프로필").font(.title).fontWeight(.bold).foregroundColor(Color.gray).padding(.top).frame(height:60)
                    Spacer()
                }
                Spacer().frame(height:20)
                HStack{
                    Text("나의 프로필")
                        .font(.title2)
                        .foregroundColor(Color.gray)
                    
                    Spacer()
                    NavigationLink(destination: EditProfile(placeHolderName: nickName, placeHoldertComment: comment)){
                        Label {
                            Text("수정하기")
                                .fontWeight(.regular)
                                .foregroundColor(Color.gray)
                        } icon:{
                            Image(systemName: "square.and.pencil")
                                .foregroundColor(Color.gray)
                                .frame(width: 15.0, height: 15.0)
                        }
                    }
                }
                Divider().frame(width: 330.0,height: 3)
                Spacer()
                    .frame(height: 15.0)
                ProfileDetail(letImageUrl: imageUrl, letNickName: nickName, letComment: comment, letInterests: interests)
                Divider().frame(width: 330.0, height: 10.0)
                VoteResults()
                Spacer().frame(height: 150)
                VStack{
                    Button("로그아웃") {
                        
                    }
                    // 서브뷰라서 네비게이션링크 달기어려움
                    .foregroundColor(.white)
                    .frame(width: 250, height: 42, alignment: .center)
                    .background(.blue)
                    .cornerRadius(10)
                    .padding(.vertical, 24.0)
                    .frame(height: 130.0)
                    Spacer().frame(height:50)
                }
                
            }.padding(.horizontal)
        }
    }
}




struct ProfileDetail: View {
    let letImageUrl: String
    let letNickName: String
    let letComment: String
    let letInterests: [String]
    
    var body: some View {
        VStack{
            HStack{
                Image(letImageUrl).frame(width:120.0,height:120).clipShape(Circle()).shadow(radius: 10).overlay(Circle().stroke(Color.gray,lineWidth: 5))
                
                VStack(alignment:.leading){
                    Text(letNickName).font(.headline).fontWeight(.heavy).foregroundColor(Color.black).multilineTextAlignment(.leading).padding(.trailing, 75.0).frame(width:200.0)
                    Spacer().frame(height:5.0)
                    Text(letComment)
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundColor(Color.gray)
                        .multilineTextAlignment(.leading)
                        .frame(width: 200.0,height: 50)
                    
                }
            }
            Spacer().frame(height:15)
            HStack{
                Spacer()
                    ZStack{
                        Image(systemName: letInterests[0])
                            .resizable(resizingMode: .stretch)
                            .foregroundColor(Color.black).frame(width: 35
                                                                , height: 35)
                        VStack{
                            Spacer()
                                .frame(height: 20.0)
                            HStack{
                                Image(systemName: "crown.fill").resizable(resizingMode: .stretch)
                                    .foregroundColor(Color.yellow)
                                    .padding(.all, 0.0)
                                    .frame(width: 20
                                           , height: 20).clipShape(Circle()).shadow(radius: 5).overlay(Circle().stroke(Color.gray,lineWidth: 3))
                            }
                            .padding(.leading)
                            .frame(width: 35.0, height: 35.0)
                            
                        }
                        .frame(width: 40.0)
                        
                    }
                Spacer().frame(width:35)
                ZStack{
                    Image(systemName: letInterests[1])
                        .resizable(resizingMode: .stretch)
                        .foregroundColor(Color.black).frame(width: 35
                                                            , height: 35)
                    VStack{
                        Spacer()
                            .frame(height: 20.0)
                        HStack{
                            Image(systemName: "crown.fill").resizable(resizingMode: .stretch)
                                .foregroundColor(Color.yellow)
                                .padding(.all, 0.0)
                                .frame(width: 20
                                       , height: 20).clipShape(Circle()).shadow(radius: 5).overlay(Circle().stroke(Color.gray,lineWidth: 3))
                        }
                        .padding(.leading)
                        .frame(width: 35.0, height: 35.0)
                        
                    }
                    .frame(width: 40.0)
                    
                }
            Spacer().frame(width:35)
                    Image(systemName: letInterests[2])
                        .resizable(resizingMode: .stretch)
                        .foregroundColor(Color.black).frame(width: 35
                                                            , height: 35)
                Spacer()
            }
        }
    }
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        Profile()
    }
}
