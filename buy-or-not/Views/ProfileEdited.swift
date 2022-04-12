//
//  ProfileEdited.swift
//  buy-or-not
//
//  Created by David_ADA on 2022/04/12.
//


import SwiftUI
import UIKit

struct EditVoteResult: View {
    
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


struct EditProfile: View {
    let placeHolderName:String
    let placeHoldertComment:String
    @State var imageUrl: String = "profile"
    @State var nickName: String = "배고픈20대"
    @State var comment: String = "전자기기에 관심이 많은 20대 입니다."
    @State var interests: Array = ["tshirt","desktopcomputer","airtag"]
    
    var body: some View {
        NavigationView{
            VStack{
                HStack{
                    
                    Spacer()
                    
                    Text("프로필 수정").font(.title).fontWeight(.bold).foregroundColor(Color.gray).padding(.top).frame(height:60)
                    Spacer()
                }
                Spacer().frame(height:20)
                HStack{
                    Text("나의 프로필")
                        .font(.title2)
                        .foregroundColor(Color.gray)
                    
                    Spacer()
                }
                Divider().frame(width: 330.0,height: 3)
                Spacer()
                    .frame(height: 15.0)
                EditProfileDetail(letImageUrl: imageUrl, letNickName: nickName, letComment: comment, letInterests: interests)
                Divider().frame(width: 330.0, height: 10.0)
                EditVoteResult()
                Spacer().frame(height: 150)
                VStack{
                    Button("수정완료") {
                        
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




struct EditProfileDetail: View {
    let letImageUrl: String
    let letNickName: String
    let letComment: String
    let letInterests: [String]
    @State private var image = UIImage()
    @State private var showSheet = false
    @State private var changedName: String = ""
    @State private var changeComment: String = ""
    
    var body: some View {
        VStack{
            HStack{
                Image(letImageUrl).frame(width:120.0,height:120).clipShape(Circle()).shadow(radius: 10).overlay(Circle().stroke(Color.gray,lineWidth: 5))
                VStack{
                    Spacer().frame(height: 70)
                    Image(uiImage: self.image)
                        .resizable()
                        .frame(width: 30, height: 30)
                        .background(Color.black.opacity(0.2))
                        .background(
                            Image(systemName: "camera.fill"))
                        .aspectRatio(contentMode: .fill).onTapGesture {
                            showSheet = true
                        }
                        .sheet(isPresented: $showSheet) {
                            // Pick an image from the photo library:
                            ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image)
                        }
                }
            
            VStack(alignment:.leading){
                TextField(letNickName, text: $changedName)
                        .keyboardType(.default) //이메일용 키보드
                        .padding(12.0)
                        .frame(width: 100, height: 30)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.gray, lineWidth: 0.5))
                Spacer().frame(height:10)
                TextField(letComment, text: $changeComment)
                    .keyboardType(.default) //이메일용 키보드
                    .padding(12.0)
                    .frame(width: 192, height: 80)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.gray, lineWidth: 0.5))
            }
        }
Spacer().frame(height:15)
}
HStack{
    Spacer().frame(width:100)
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
            .foregroundColor(Color.black).frame(width: 35, height: 35)
        Spacer()
        }
    }
}

struct EditProfile_Previews: PreviewProvider {
    static var previews: some View {
        EditProfile(placeHolderName: "수정값", placeHoldertComment: "수정값")
    }
}
