//
//  FindMemberInfoPage.swift
//  buy-or-not
//
//  Created by 한경준 on 2022/04/08.
//

import SwiftUI

struct FindMemberInfoPage: View {
    
    @State var findEmailNameInput: String = ""
    @State var findEmailNickNameInput: String = ""

    var body: some View {
        VStack {
            Text("이메일 찾기")
                .font(.title2)
                .foregroundColor(Color.gray)
                .padding(.bottom, 24.0)
            
            TextField("이름", text: $findEmailNameInput)
                .padding(.horizontal, 12.0)
                .frame(width: 300, height: 48)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.gray, lineWidth: 0.5))
                .padding(.vertical, 6.0)
            
            TextField("닉네임", text: $findEmailNickNameInput)
                .padding(.horizontal, 12.0)
                .frame(width: 300, height: 48)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.gray, lineWidth: 0.5))
                .padding(.vertical, 6.0)
            
            Text("비밀번호 찾기")
                .font(.title2)
                .foregroundColor(Color.gray)
                .padding(.bottom, 24.0)
            
        }
    }
}

struct FindMemberInfoPage_Previews: PreviewProvider {
    static var previews: some View {
        FindMemberInfoPage()
    }
}
