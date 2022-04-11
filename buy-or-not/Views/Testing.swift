//
//  Testing.swift
//  buy-or-not
//
//  Created by 이지원 on 2022/04/12.
//

import SwiftUI

struct Testing: View {
    @State var data = UserDataManager()
    @State var data2 = PostDataManager()
    //@State user
    var body: some View {
        ForEach(0..<data.json.count, id: \.self){
            num in
            let user = data.json[num]
            Text(user.name)
        }
        
        ForEach(0..<data2.json.count, id: \.self){
            num in
            let post = data2.json[num]
            Text(post.title)
        }
        
    }
}

struct Testing_Previews: PreviewProvider {
    static var previews: some View {
        Testing()
    }
}
