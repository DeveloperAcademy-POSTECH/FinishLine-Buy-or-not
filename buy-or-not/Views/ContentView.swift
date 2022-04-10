
//
//  ContentView.swift
//  buy-or-not
//
//  Created by Noah's Ark on 2022/04/06.
//
//  test
import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("ContentView는 기본 화면 입니다.")
                .padding()
            Text("views 요소에 해당합니다. SwiftUI View 파일로 만들어주세요.")
                .padding()
            
            // models 폴더의 Title 파일 확인
            // text가 요구하는 값을 할당합니다.
            Title(text: "저는 서브뷰 입니다. models 입니다.")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
