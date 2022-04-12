//
//  Profile.swift
//  buy-or-not
//
//  Created by Apple_Academy on 2022/04/08.
//
import SwiftUI
import UIKit
import FirebaseAuth
import FirebaseFirestore
//ToDO 네비게이션 버튼이 뒤로가기팝, 수정하기 작동이 갑자기안됌 
struct Profile: View {
    @State private var imageString: String = "profile"
    @State private var nickName: String = "배고픈20대"
    @State private var introduceComment: String = "전자기기에 관심이 많은 20대 입니다."
    @State private var badgeBools: Array = [true,true,false]
    //    @State var user = User(name: <#T##String#>, comment: <#T##String#>, nickname: <#T##String#>, interested: <#T##String#>, img: <#T##String#>)
//
//    
//    init () {
//
////            { (user, error) in
////                if error == nil{
////                    let db = Firestore.firestore()
////                    var ref: DocumentReference? = nil
//
//    }
//
    
    var body: some View {
        NavigationView{
            VStack{
                HStack{
                    
                    Spacer()
                    
                    //                    user.setUserName(name: "Daivid")
                    // print(user.getUserName())
                    Text("프로필").font(.title).fontWeight(.bold).foregroundColor(Color.gray).padding(.top).frame(height:60)
                    Spacer()
                }
                Spacer().frame(height:20)
                HStack{
                    Text("나의 프로필")
                        .font(.title2)
                        .foregroundColor(Color.gray)
                    
                    Spacer()
                    NavigationLink(destination: Text("수정하기 화면")){
                        Label {
                            Text("수정하기")
                                .fontWeight(.regular)
                                .foregroundColor(Color(hex: "8A67E8"))
                        } icon:{
                            Image(systemName: "square.and.pencil")
                                .foregroundColor(Color(hex: "8A67E8"))
                                .frame(width: 15.0, height: 15.0)
                        }
                    }
                }
                Divider().frame(width: 330.0,height: 3)
                Spacer()
                    .frame(height: 15.0)
                ProfileDetail(profileImage:imageString,nickName:nickName,introduceComment:introduceComment,iconArrays:badgeBools)
                Spacer().frame(height:40)
                HStack{
                    Spacer()
                        .frame(width: 50
                               
                        )
                    NavigationLink(destination:
                                    Text("나의질문화면").navigationBarHidden(true)
                    ){
                        VStack{
                            Image(systemName:"questionmark.circle.fill")
                                .resizable(resizingMode: .stretch)
                                .foregroundColor(Color(hex: "8A67E8"))
                                .frame(width: 40.0, height: 40.0)
                            Text("나의질문")
                                .foregroundColor(Color(hex: "8A67E8"))
                            
                        }
                    }
                    Spacer()
                    NavigationLink(destination: Text("나의답변화면")){
                        VStack{
                            Image(systemName:"exclamationmark.bubble.fill")
                                .resizable(resizingMode: .stretch)
                                .foregroundColor(Color(hex: "8A67E8"))
                                .frame(width: 40.0, height: 40.0)
                            Text("나의답변")
                                .foregroundColor(Color(hex: "8A67E8"))
                            
                        }
                    }
                    Spacer()
                        .frame(width: 50.0)
                }
                Divider().frame(width: 330.0, height: 10.0)
                ProfileBottom()
                
            }
            .padding(.horizontal)
        }
    }
}
    struct ProfileBottom: View {
        
        var body: some View {
            VStack{
                HStack{
                    Label {
                        Text("공지사항")
                            .fontWeight(.semibold)
                            .foregroundColor(Color.gray)
                    } icon:{
                        Image(systemName: "mic.fill")
                            .foregroundColor(Color.gray)
                            .frame(width: 15.0, height: 15.0)
                    }
                }
                .padding(/*@START_MENU_TOKEN@*/.trailing, 230.0/*@END_MENU_TOKEN@*/)
                Spacer().frame(height:15)
                HStack{
                    Label {
                        Text("자주 묻는 질문")
                            .fontWeight(.semibold)
                            .foregroundColor(Color.gray)
                    } icon:{
                        Image(systemName: "phone.fill")
                            .foregroundColor(Color.gray)
                            .frame(width: 15.0, height: 15.0)
                    }
                }
                .padding(.trailing, 195.0)
                Spacer()
                    .frame(height: 150)
                Button("로그아웃") {
                    
                }
                // 서브뷰라서 네비게이션링크 달기어려움
                .foregroundColor(.white)
                .frame(width: 250, height: 42, alignment: .center)
                .background(Color(hex: "8A67E8"))
                .cornerRadius(10)
                .padding(.vertical, 24.0)
                Spacer()
                    .frame(height: 130.0)
            }
            
        }
    }
    
    
    
    
    struct ProfileDetail: View {
        let profileImage : String
        let nickName : String
        let introduceComment:String
        let iconArrays:Array<Bool>
        var body: some View {
            VStack{
                HStack{
                    Image(profileImage).frame(width:120.0,height:120).clipShape(Circle()).shadow(radius: 10).overlay(Circle().stroke(Color.gray,lineWidth: 5))
                    VStack(alignment:.leading){
                        Text(nickName).font(.headline).fontWeight(.heavy).foregroundColor(Color.black).multilineTextAlignment(.leading).padding(.trailing, 75.0).frame(width:200.0)
                        Spacer().frame(height:5.0)
                        Text(introduceComment)
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .foregroundColor(Color.gray)
                            .multilineTextAlignment(.leading)
                            .frame(width: 200.0,height: 50)
                        
                    }
                }
                Spacer().frame(height:15)
                HStack{
                    Spacer().frame(width:100)
                    if iconArrays[0] {
                        ZStack{
                            Image(systemName: "tshirt")
                                .resizable(resizingMode: .stretch)
                                .foregroundColor(Color(hex: "7E3CC2")).frame(width: 35
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
                        
                    } else{
                        Image(systemName: "tshirt")
                            .resizable(resizingMode: .stretch)
                            .foregroundColor(Color(hex: "7E3CC2")).frame(width: 35
                                                                , height: 35)
                    }
                    Spacer().frame(width:35)
                    if iconArrays[1] {
                        ZStack{
                            Image(systemName: "desktopcomputer")
                                .resizable(resizingMode: .stretch)
                                .foregroundColor(Color(hex: "7E3CC2")).frame(width: 35
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
                        
                    } else{
                        Image(systemName: "desktopcomputer")
                            .resizable(resizingMode: .stretch)
                            .foregroundColor(Color(hex: "7E3CC2")).frame(width: 35
                                                                , height: 35)
                    }
                    Spacer().frame(width:35)
                    if iconArrays[1] {
                        ZStack{
                            Image(systemName: "airtag")
                                .resizable(resizingMode: .stretch)
                                .foregroundColor(Color(hex: "7E3CC2")).frame(width: 35
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
                        
                    } else{
                        Image(systemName: "airtag")
                            .resizable(resizingMode: .stretch)
                            .foregroundColor(Color(hex: "7E3CC2")).frame(width: 35
                                                                , height: 35)
                        
                    }
                    Spacer().frame(width:100)
                }
            }
        }
    }

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        Profile()
    }
}
