//
//  SignUpPage.swift
//  buy-or-not
//
//  Created by 한경준 on 2022/04/07.
//

import SwiftUI
import AuthenticationServices

struct SignUpPage: View {
    
    //이메일 및 비밀번호 입력
    @State var signUpEmailInput: String = ""
    @State private var signUpPasswordInput: String = ""
    @State private var signUpPasswordCheck: String = ""
    
    //이름 및 닉네임 입력 - 이름 입력 삭제
    //    @State var nameInput: String = ""
    @State var nickNameInput: String = ""
    
    //관심분야 체크박스
    @State var interestCheckFashion: Bool = false
    @State var interestCheckInterior: Bool = false
    @State var interestCheckFood: Bool = false
    @State var interestCheckDigital: Bool = false
    @State var interestCheckHobby: Bool = false
    @State var interestCheckEtc: Bool = false
    
    //체크박스 배열
    @State var isChecked: [Bool] = [false,false,false,false,false,false]
    @State var checkedCategory: [String] = []
    
    //가입하기 버튼 비활성화
    @State private var signUpButtonPressed = false
    
    
    var body: some View {
        ScrollView {
            VStack() {
                //회원가입 텍스트
                Text("회원가입")
                    .font(.title2)
                    .foregroundColor(Color.black)
                    .padding(.bottom, 24.0)
                
                //이메일 입력 및 중복확인
                HStack() {
                    TextField("이메일", text: $signUpEmailInput)
                        .autocapitalization(.none)
                        .keyboardType(.emailAddress) //이메일용 키보드
                        .padding(12.0)
                        .frame(width: 192, height: 48)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.gray, lineWidth: 0.5))
                    Button("중복확인") {
                        //action
                    }
                    .foregroundColor(.white)
                    .frame(width: 100, height: 48, alignment: .center)
                    .background(Color(hex: "8A67E8"))
                    .cornerRadius(12)
                    
                }
                .padding(.vertical, 6.0)
                
                //비밀번호 입력
                ZStack() {
                    SecureInputView("비밀번호", text: $signUpPasswordInput)
                        .padding(.horizontal, 12.0)
                        .frame(width: 300, height: 48)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.gray, lineWidth: 0.5)
                        )
                        .padding(.vertical, 6.0)
                }
                
                //비밀번호 확인
                ZStack() {
                    SecureInputView("비밀번호 확인", text: $signUpPasswordCheck)
                        .padding(.horizontal, 12.0)
                        .frame(width: 300, height: 48)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.gray, lineWidth: 0.5)
                        )
                        .padding(.vertical, 6.0)
                }
                
                //비밀번호 중복확인
                if signUpPasswordInput=="" {
                    
                }
                else if signUpPasswordInput==signUpPasswordCheck {
                    Text("비밀번호가 일치합니다.")
                        .foregroundColor(.blue)
                        .padding(.vertical, 6.0)
                }
                else {
                    Text("비밀번호가 일치하지 않습니다.")
                        .foregroundColor(.red)
                        .padding(.vertical, 6.0)
                }
                
                Group {
                    //이름 입력 - 삭제
                    //                        TextField("이름", text: $nameInput)
                    //                            .padding(.horizontal, 12.0)
                    //                            .frame(width: 300, height: 48)
                    //                            .overlay(
                    //                                RoundedRectangle(cornerRadius: 12)
                    //                                    .stroke(Color.gray, lineWidth: 0.5))
                    //                            .padding(.vertical, 6.0)
                    
                    
                    //닉네임 입력 및 중복확인
                    HStack() {
                        TextField("닉네임", text: $nickNameInput)
                            .padding(12.0)
                            .frame(width: 192, height: 48)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.gray, lineWidth: 0.5))
                        Button("중복확인") {
                            /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
                        }
                        .foregroundColor(.white)
                        .frame(width: 100, height: 48, alignment: .center)
                        .background(Color(hex: "8A67E8"))
                        .cornerRadius(12)
                        
                    }
                    .padding(.vertical, 6.0)
                    
                    
                    //관심분야 텍스트
                    Text("관심분야")
                        .font(.title2)
                        .foregroundColor(Color.black)
                        .padding(.vertical, 24.0)
                }
                
                
                //관심분야
                Group {
                    interestSellect(isChecked: $isChecked[0], interestIcon: "tshirt", interestTitle: "패션/뷰티", interestSubTitle: "#신발 #티셔츠 #화장품 #가을코디", checkboxInput: interestCheckFashion)
                    
                    interestSellect(isChecked: $isChecked[1], interestIcon: "bed.double", interestTitle: "가구/인테리어", interestSubTitle: "#소파 #매트리스 #스탠드 #그릇", checkboxInput: interestCheckInterior)
                    
                    interestSellect(isChecked: $isChecked[2],interestIcon: "fork.knife", interestTitle: "식품/외식", interestSubTitle: "#자취요리 #맛집 #가성비 #JMT", checkboxInput: interestCheckFood)
                    
                    interestSellect(isChecked: $isChecked[3],interestIcon: "desktopcomputer", interestTitle: "전자제품/디지털 가전", interestSubTitle: "#컴퓨터 #세탁기 #맥북 #모니터", checkboxInput: interestCheckDigital)
                    
                    interestSellect(isChecked: $isChecked[4],interestIcon: "gamecontroller", interestTitle: "취미/여가", interestSubTitle: "#여행 #게임 #스포츠 #힐링 #음악", checkboxInput: interestCheckHobby)
                    
                    interestSellect(isChecked: $isChecked[5],interestIcon: "ellipsis.circle", interestTitle: "기타", interestSubTitle: "#자동차 #결혼기념일 #생일선물", checkboxInput: interestCheckEtc)
                }
                
                
                //가입완료 버튼
                
                
                Button {
                    //action
                    signUpButtonPressed = true//disabled용 코드
                    
                    if isChecked[0]==true {
                        checkedCategory.append("tshirt")
                    }
                    if isChecked[1]==true {
                        checkedCategory.append("bed.double")
                    }
                    if isChecked[2]==true {
                        checkedCategory.append("fork.knife")
                    }
                    if isChecked[3]==true {
                        checkedCategory.append("desktopcomputer")
                    }
                    if isChecked[4]==true {
                        checkedCategory.append("gamecontroller")
                    }
                    if isChecked[5]==true {
                        checkedCategory.append("ellipsis.circle")
                    }

                    
                    print(signUpEmailInput)
                    print(nickNameInput)
                    print(checkedCategory)
                    
                    

                }label: {
                    Text(signUpButtonPressed ?"앱 가입을 진행중이에요" :"가입하기" )
                        .frame(width: 300, height: 42, alignment: .center)
                }
                .foregroundColor(.white)
                .background(signUpButtonPressed ?.gray :Color(hex: "8A67E8") )
                .cornerRadius(12)
                .padding(.vertical, 24.0)
                .disabled(signUpButtonPressed == true)
            }
            .frame(width: 390, alignment: .center)
            
            
        }
    }
    
    struct SignUpPage_Previews: PreviewProvider {
        static var previews: some View {
            SignUpPage()
        }
    }
}
