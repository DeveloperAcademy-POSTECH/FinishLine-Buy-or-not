//  Profile.swift
//  buy-or-not
//
//  Created by Apple_Academy on 2022/04/08.
// Geometry 적용하기
// User 자기가 투표한 포스트의 ID를 가진다
import SwiftUI
import UIKit
import FirebaseAuth
//ToDO 네비게이션 버튼이 뒤로가기팝, 수정하기 작동이 갑자기안됌

struct signOutContentView: View{
    @State var signOutSuccess = false
    @State var signInSuccess = true
    
    @Binding var data: QuestionItemManager
    @Binding var user: UserDataManager
    var body: some View{
        if signOutSuccess {
            LogInPage()
        }
        else{
            Profile(signOutSuccess: $signOutSuccess, data: $data, user: $user)
        }
    }
}

struct VoteResults: View {
    @Binding var data: QuestionItemManager
    @Binding var user: UserDataManager
    
    @State private var feedState = false
    @State var fromWhere: Bool = true
    
    @State var previewImg: String = "default"
    @State var previewState: Bool = false
    
    @State var voteDone: Bool = true
    
    func getMyAskData() -> [QuestionItemData] {
        var box: [QuestionItemData] = []
        for feed in data.json {
            if feed.author == user.json[0].nickName {
                box.append(feed)
            }
        }
        return box
    }
    
    func getMyAnsData() -> [QuestionItemData] {
        var box: [QuestionItemData] = []
        for feed in data.json {
            for i in feed.items {
                for j in i.votes {
                    if j == user.json[0].nickName {
                        box.append(feed)
                    }
                }
            }
        }
        return box
    }
    
    var body: some View {
        VStack(alignment: .leading){
            
            HStack {
                Spacer()
                Text("나의 질문").font(.system(size: 21, weight: .regular)).onTapGesture {
                    feedState = false
                }
                Spacer()
                Text("나의 답변").font(.system(size: 21, weight: .regular)).onTapGesture {
                    feedState = true
                }
                Spacer()
            }
            Divider()
                .foregroundColor(Color(hex: "979797"))
            Spacer().frame(height:15)
            //투표와 관련된 뷰들을 넣어줘야한다. 그 사용자가 투표한 결과값들을 가져와야한다.
            if !feedState {
                ScrollView {
                    // 피드 컨텐츠 영역
                    LazyVStack {
                        let fixedData = getMyAskData()
                        ForEach(0..<fixedData.count, id: \.self) { num in
                            let feed = fixedData[num]
                            let passedTime = (DateCalculator(originatedDate:feed.timeStamp).dateDiff.day! > 1) ? DateCalculator(originatedDate:feed.timeStamp).dateDiff.day! : DateCalculator(originatedDate:feed.timeStamp).dateDiff.hour!
                            
                            //                                      var timeStemp = "default"
                            
                            QuestionItem(author: feed.author, title: feed.title, category: feed.category, items: feed.items, timestamp: passedTime, previewImg: $previewImg, previewState: $previewState, fromWhere: $fromWhere)
                        }
                    }
                }
            } else {
                ScrollView {
                    // 피드 컨텐츠 영역
                    LazyVStack {
                        let fixedData = getMyAnsData()
                        ForEach(0..<fixedData.count, id: \.self) { num in
                            let feed = fixedData[num]
                            let passedTime = (DateCalculator(originatedDate:feed.timeStamp).dateDiff.day! > 1) ? DateCalculator(originatedDate:feed.timeStamp).dateDiff.day! : DateCalculator(originatedDate:feed.timeStamp).dateDiff.hour!
                            
                            //                                      var timeStemp = "default"
                            
                            QuestionItem(author: feed.author, title: feed.title, category: feed.category, items: feed.items, timestamp: passedTime, previewImg: $previewImg, previewState: $previewState, fromWhere: $fromWhere)
                        }
                    }
                }
            }
            
            
        }.frame(minHeight:280)
    }
}


struct Profile: View {
    @Binding var signOutSuccess: Bool
    @State var imageUrl: String = "https://pngset.com/images/apple-unveils-new-emoji-face-mask-memoji-characters-hypebeast-apple-memoji-head-clothing-apparel-toy-transparent-png-2663192.png"
    @State var nickName: String = "Halohalo"
    @State var comment: String = "전자기기에 관심이 많은 20대 입니다."
    @State var interests: Array = ["tshirt", "gamecontroller"]
    
    @Binding var data: QuestionItemManager
    @Binding var user: UserDataManager
    
    @State var imageState: Bool = false
    //@Binding var signOutSuccess: Bool
    
    var authInstance = FirebaseAuth.Auth.auth()
    
    var body: some View {
        VStack{
            Spacer()
                .frame(height:20)
            ProfileDetail(letImageUrl: imageUrl, letNickName: nickName, letComment: comment, letInterests: interests, imageState: $imageState)
            
            Spacer()
                .frame(height:54)
            VoteResults(data: $data, user: $user)
            Button("로그아웃") {
                // 서브뷰라서 네비게이션링크 달기어려움
                do { try authInstance.signOut()
                    signOutSuccess.toggle()
                }
                catch { print("already logged out") }
            }
            .foregroundColor(.white)
            .frame(width: 250, height: 42, alignment: .center)
            .background(.blue)
            .cornerRadius(10)
            .padding(.vertical, 24.0)
            .frame(height: 130.0)
        }
        .padding(.horizontal,17)
        .navigationTitle("프로필")
        .navigationBarItems(
            trailing: NavigationLink(
                destination: EditProfile(placeHolderName: $nickName, placeHoldertComment: $comment, data: $data, user: $user, imageState: $imageState) // 검색 뷰로 연결
            ){
                Text("편집")
            }
        )
    }
}




struct ProfileDetail: View {
    let letImageUrl: String
    let letNickName: String
    let letComment: String
    let letInterests: [String]
    
    @Binding var imageState: Bool
    
    var body: some View {
        VStack(alignment: .leading){
            HStack(alignment: .top, spacing: 17){
                if imageState {
                    Image(letImageUrl)
                        .resizable()
                        .frame(width:90.0,height:90)
                        .aspectRatio(contentMode: .fit)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color(hex: "979797"),lineWidth: 1))
                } else {
                    Image("profile")
                        .resizable()
                        .frame(width:90.0,height:90)
                        .aspectRatio(contentMode: .fit)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color(hex: "979797"),lineWidth: 1))
                }
                
                //
                
                VStack(alignment:.leading){
                    Text(letNickName)
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(Color.black)
                        .multilineTextAlignment(.leading)
                    Spacer().frame(height:5.0)
                    Text(letComment)
                        .font(.system(size: 14, weight: .regular))
                        .foregroundColor(Color(hex: "AAAAAA"))
                        .multilineTextAlignment(.leading)
                    
                }
                .padding(.top, 16.0)
            }
            Spacer()
                .frame(height:36)
            Text("관심목록")
                .font(.system(size: 21, weight: .regular))
            Divider()
                .background(Color(hex: "979797"))
            //                .padding(.horizontal:)
            
            Spacer().frame(height:15)
            HStack{
                interestedCategory(letInterests:letInterests[0])
                interestedCategory(letInterests:letInterests[1])
            }
            
        }
        //        .background(Color.red)
        
    }
}


struct interestedCategory: View {
    var letInterests : String
    
    var body: some View {
        ZStack{
            Text (
                "\(Image(systemName: letInterests))"
            )
            .font(.system(size: 24, weight: .medium))
            
            Circle()
                .strokeBorder(lineWidth: 1)
                .foregroundColor(Color(hex: "979797"))
                .frame(width: 60, height: 60)
        }
        Spacer().frame(width:12)
    }
}
