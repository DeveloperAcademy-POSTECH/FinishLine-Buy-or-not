//
//  Question.swift
//  buy-or-not
//
//  Created by 이지원 on 2022/04/07.
//

import SwiftUI

private let categorys: [String] = [
    "패션/뷰티", "가구/인테리어", "식품/외식", "전자제품/디지털가전", "취미/여가", "기타"]

struct Contents: View{
    let number: Int
    @State private var topExpand: Bool = false
    @State private var name: String = ""
    @State private var price: String = ""
    @State private var link: String = ""
    
    @State private var imagePickerPresented = false
    @State private var selectedImage: UIImage?
    @State private var profileImage: Image?
    
    var body: some View{
        DisclosureGroup("고민항목 \(number)", isExpanded: $topExpand) {
            TextField("고민항목 이름", text: $name)
            TextField("(선택) 가격을 입력해주세요", text: $price)
            TextField("(선택) 링크 추가", text: $link)
            Button("이미지 추가") {
                imagePickerPresented.toggle()
                
            }
        }
    }
    
    func nextItem() -> Bool{
        return !name.isEmpty
    }
    
    
}

struct Question: View {
    
    @State private var qCategory: String = "카테고리"
    @State private var categoryExpand: Bool = false
    @State private var Bools: [Bool] = [true, false]
    
    @State private var qTitle: String = ""
    
    @State private var topExpand: [Bool] = [true, false, false]
    @State private var addItem: [Bool] = [true, false, false, false]
    @State private var name: [String] = ["", "", ""]
    @State private var price: [String] = ["", "", ""]
    @State private var link: [String] = ["", "", ""]
    @State private var content = ""
    
    @State private var imagePickerPresented = [false, false, false]
    
    
    
    var body: some View {
        NavigationView {
            VStack{
                Form{
                    TextField("글 제목", text: $qTitle)
                    // 카테고리
                    DisclosureGroup(qCategory, isExpanded: $categoryExpand) {
                        List{
                            ForEach(categorys, id: \.self){ category in
                                Text(category).onTapGesture {
                                    qCategory = category
                                    categoryExpand = Bools[1]
                                }.listRowBackground(self.qCategory == category ? Color.gray : Color(UIColor.white))
                            }
                        }
                    }
                    
                    // 고민항목
                    ForEach(0..<3){num in
                        if addItem[num]{
                            DisclosureGroup("고민항목 \(num+1)", isExpanded: $topExpand[num]){
                                TextField("고민항목 이름", text: $name[num]).onTapGesture{
                                    addItem[num+1] = Bools[0]
                                }
                                TextField("(선택) 가격을 입력해주세요", text: $price[num])
                                TextField("(선택) 링크 추가", text: $link[num])
                                
                                Button("이미지 추가") {
                                    imagePickerPresented[num].toggle()
                                    
                                }
                            }
                        }
                    }
                    
                    // 고민내용
                    ZStack(alignment: .topLeading) {
                        RoundedRectangle(cornerRadius: 8, style: .continuous)
                            .fill(Color(UIColor.secondarySystemBackground))
                        
                        if content.isEmpty {
                            Text("고민내용")
                                .foregroundColor(Color(UIColor.placeholderText))
                                .padding(.horizontal, 8)
                                .padding(.vertical, 12)
                        }
                        
                        TextEditor(text: $content)
                            .padding(4)
                        
                    }
                    .frame(width: 300, height: 300)
                }
                
                
                Button("등록하기") {
                    // action
                }.foregroundColor(.white)
                    .frame(width: 180, height: 42, alignment: .center)
                    .background(.blue)
                    .cornerRadius(5)
                    .padding(.vertical, 24.0)
            }
            
        }.navigationBarTitle("질문하기")
    }
}

struct Question_Previews: PreviewProvider {
    static var previews: some View {
        Question()
    }
}
