//
//  LoginPage.swift
//  buy-or-not
//
//  Created by 한경준 on 2022/04/07.
//
import SwiftUI
import AuthenticationServices

struct LogInPage: View {
    
    @State var emailInput: String = ""
    @State private var passwordInput: String = ""
    @State var checkboxInput: Bool = false
    
    var body: some View {
        NavigationView {
            VStack() {
                Image("BuyOrNotLogo")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .padding(.top, 48)
                    .padding(.bottom, 6)
                
                TextField("이메일", text: $emailInput)
                    .keyboardType(.emailAddress) //이메일용 키보드
                    .padding(.horizontal, 12.0)
                    .frame(width: 300, height: 48)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.gray, lineWidth: 0.5)
                    )
                    .padding(.vertical, 6.0)
                
                ZStack() {
                    SecureInputView("비밀번호", text: $passwordInput)
                        .padding(.horizontal, 12.0)
                        .frame(width: 300, height: 48)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.gray, lineWidth: 0.5)
                        )
                        .padding(.vertical, 6.0)
                }
                
                //아이디 기억하기
                HStack() {
                    Toggle(isOn: $checkboxInput) {
                    }
                    .toggleStyle(CheckBoxView())
                    Text(" 아이디 기억하기")
                        .foregroundColor(.gray)
                }
                .padding(.vertical, 12.0)
                
                
                Button("로그인") {
                    
                }
                .foregroundColor(.white)
                .frame(width: 180, height: 42, alignment: .center)
                .background(.blue)
                .cornerRadius(5)
                .padding(.vertical, 24.0)
                
                //애플로 로그인
                SignInWithAppleButton(
                    onRequest: { request in
                        
                    },
                    onCompletion: { result in
                        
                    }
                )
                .signInWithAppleButtonStyle(.whiteOutline)
                .frame(width: 300.0, height: 42.0)
                .padding(.vertical, 24.0)
                
                Button("아이디/비밀번호 찾기") {
                    
                }
                .padding(.top, 24.0)
                .padding(.bottom, 12.0)
                
                
                NavigationLink(destination: SignUpPage()) {
                    Text("계정이 없으신가요?")
                }
            }
        }
}

struct LogInPage_Previews: PreviewProvider {
    static var previews: some View {
        LogInPage()
    }
}
}
