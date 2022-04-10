//
//  Answer.swift
//  buy-or-not
//
//  Created by Apple_Academy on 2022/04/09.
//

import Foundation


import SwiftUI

private let categorys: [String] = [
    "패션/뷰티", "가구/인테리어", "식품/외식", "전자제품/디지털가전", "취미/여가", "기타"]

struct Answer: View {
    @State private var topExpanded: Bool = false
    
    var body: some View {
        Form {
            TextField("글 제목", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/)
            DisclosureGroup("카테고리", isExpanded: $topExpanded)
            {
                ForEach(categorys, id: \.self){ category in
                    HStack{
                        Text(category)
                    }
                }
            }
        }
    }
}

struct Answer_Previews: PreviewProvider {
    static var previews: some View {
        Answer()
    }
}
