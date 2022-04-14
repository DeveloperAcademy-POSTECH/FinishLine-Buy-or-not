//
//  LoginPage.swift
//  buy-or-not
//
//  Created by 한경준 on 2022/04/07.
//
import SwiftUI
import AuthenticationServices
import FirebaseAuth

struct LoginContentView: View{
    @State var signInSuccess = false
    var body: some View{
        if signInSuccess {
            Main()
        }
        else{
            LogInPage(signInSuccess: $signInSuccess)
        }
    }
}

struct LogInPage: View {
    // 해결
    @Binding var signInSuccess: Bool
    //error 해결
    @State var signUpSuccess = false
    @State var emailInput: String = ""
    @State private var passwordInput: String = ""
    @State var localAutoLoginToggle: Bool = false

    //오토로그인
    @State var isAutoLogin: Bool = false
    @State var isAutoLogins: Bool = (UserDefaults.standard.string(forKey: "CHECK") != nil)
    @State var rememberEmail: String = (UserDefaults.standard.string(forKey: "ID") ?? "")
    @State var rememberPassword: String = (UserDefaults.standard.string(forKey: "PW") ?? "")
    
    @State var loginGood: Bool = true
    @State var showAlert: Bool = false
   // @State var alertError: Bool = true
    var body: some View {
        
        
        NavigationView {
            VStack() {
                
                //앱로고
                Image("BuyOrNotLogo")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .padding(.top, 48)
                    .padding(.bottom, 6)
                
                //이메일 텍스트필드
                TextField("이메일", text: $emailInput)
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress) //이메일용 키보드
                    .padding(.horizontal, 12.0)
                    .frame(width: 300, height: 48)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.gray, lineWidth: 0.5)
                    )
                    .padding(.vertical, 6.0)
                
                //비밀번호 텍스트필드
                ZStack() {
                    SecureInputView("비밀번호", text: $passwordInput)
                        .autocapitalization(.none)
                        .padding(.horizontal, 12.0)
                        .frame(width: 300, height: 48)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.gray, lineWidth: 0.5)
                        )
                        .padding(.vertical, 6.0)
                }
                
//                 HStack{
//                     //아이디 기억하기
//                     HStack() {
//                         Toggle(isOn: $checkboxInput) {
//                         }
//                         .toggleStyle(CheckBoxView())
//                         Text("아이디 기억하기")
//                             .foregroundColor(.gray)
//                     }
                    
//                     .padding(.vertical, 12.0)
//                     .padding(.trailing, 30)
                    
//                     // 자동로그인
//                     HStack() {
//                         Toggle(isOn: $isAutoLogin) {
                            
//                         }
//                         .toggleStyle(CheckBoxView())
//                         Text("자동 로그인")
//                             .foregroundColor(.gray)
//                             .font(.system(size: 18))

            
                
                
                //로그인 버튼
                Button() {
                    if isAutoLogin{
                        UserDefaults.standard.set(emailInput, forKey: "ID")
                        UserDefaults.standard.set(passwordInput, forKey: "PW")
                        UserDefaults.standard.set(isAutoLogin, forKey: "CHECK")
                        //print("saved value: \(emailInput), \(passwordInput)")
                    }
                    // 로그인 성공하면
//                    FirebaseAuth.Auth.auth().signIn(
//                        withEmail: emailInput,
//                        password: passwordInput) {result, error in
//                            guard error == nil
//                            else {
//                                return
//                            }
//                        print("You 성공")
//                        signInSuccess.toggle() // 화면 전환
//                    }
                    if loginGood {
                        showAlert.toggle()
                        loginGood.toggle()
                    } else {
                        signInSuccess.toggle()
                    }
                    
                    
                } label: {
                    Text("로그인")
                        .frame(width: 180, height: 42, alignment: .center)
                }
                  .foregroundColor(.white)
                  .background(Color(hex: "8A67E8"))
                  .cornerRadius(12)
                  .padding(.vertical, 24.0)
                  .alert(isPresented: $showAlert) {
                                              Alert(title: Text("로그인 실패"),
                                                    message: Text("아이디와 비밀번호를 확인해주세요.")
                                              )
                                          }
                 
                  
          
                
        
                
                //계정이 없으신가요? 네비게이션뷰
                NavigationLink(destination: SignUpContentView(signInSuccess: $signInSuccess)) {

                    Text("계정이 없으신가요?")
                }
                .foregroundColor(Color(hex: "8A67E8"))
                .navigationBarHidden(true)
            }
        }
        
    }
}

