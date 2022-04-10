//
//  Title.swift
//  buy-or-not
//
//  Created by Noah's Ark on 2022/04/06.
//
import Foundation
import SwiftUI

// 서브뷰 작성을 통해 동일한 모양의 뷰를 재사용 가능
struct Title: View {
    
    // 사용하고자 하는 화면에서 text에 해당하는 값을 받아옵니다.
    // text에는 텍스트만 입력할 수 있습니다.
    // FYI,   String : 텍스트 / Int, Double, Float ... : 숫자 (정수, 실수 등등 여러가지 타입 존재) / Bool -> 참, 거짓 (True / False)
    var text: String
    
    var body: some View {
        // Text에 표시하고자 하는 변수를 할당합니다.
        Text(text)
            .foregroundColor(Color.red)
            .font(.system(size: 24))
    }
}
