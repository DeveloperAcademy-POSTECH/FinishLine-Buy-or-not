//
//  File.swift
//  buy-or-not
//
//  Created by 이지원 on 2022/04/11.
//

import Foundation
struct User{ // user -> 변하지 않음
    // 이름
    //let id: String
    //let email: String
    var name: String
    var comment : String //자기소개
    var nickname: String
    var interested: String
    var img: String
    
    // user.name = "어쩌고"
    // set, get 접근 제어자 필요 없음 (internal) -> swift에서 많이 사용 안함 (굳이 쓸 필요가 x)
    // private으로 설정되어있어야 필요.
    // struct : 참조 값이 아님
    
    mutating func setUser(){
        var dum = serverData()
        var userName = dum.dumData["nickName"]
        
    }
}

