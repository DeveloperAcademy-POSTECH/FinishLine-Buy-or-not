//
//  FirebaseTest.swift
//  buy-or-not
//
//  Created by leejunmo on 2022/04/12.
//

import SwiftUI

struct FirebaseTest: View {
    
    var testPostManager = Posts()
    
    var body: some View {
        Text("post Test").onTapGesture {
            testPostManager.postData(title: "testse", timeStamp: "sadfasdf", items: [["asdf", "asdf"]])
        }
        Spacer()
        Text("get Test").onTapGesture {
            //testPostManager.fetchData()
            //print(testPostManager.localPosts)
        }
    }
}

struct FirebaseTest_Previews: PreviewProvider {
    static var previews: some View {
        FirebaseTest()
    }
}
