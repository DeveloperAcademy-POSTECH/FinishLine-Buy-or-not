//
//  UserData.swift
//  buy-or-not
//
//  Created by Noah's Ark on 2022/04/08.
//

import Foundation

// json 파일의 내용을 적용할 struct 입니다.
// 데이터가 저장될 형식(schema, model)이며, 앞으로 회원가입, 로그인, 프로필 조회 등 유저 관련 데이터는 아래의 형식을 준수합니다.
// 반드시 아래의 양식을 준수해야 하고, 그렇지 않으면 데이터가 표시되지 않습니다. (fatal error 발생)
struct UserData: Codable, Identifiable {
    
    // https://developer.apple.com/documentation/foundation/archives_and_serialization/encoding_and_decoding_custom_types
    // Codable 타입은 CodingKeys 라고 하는 특별한 enum을 선언할 수 있습니다. CodingKeys는 CodingKey 프로토콜을 준수합니다.
    // 해당 enum이 존재할 시, enum에 포함된 모든 case들은 Codable 타입이 인코딩(encoding) 혹은 디코딩(decoding) 될 떄 반드시 포함되어야 할 조건으로써 활용됩니다.
    // case의 명칭은 codable 타입 내 변수의 명칭과 동일해야 합니다.
    
    // enum (enumeration) : https://docs.swift.org/swift-book/LanguageGuide/Enumerations.html
    // protocol : https://docs.swift.org/swift-book/LanguageGuide/Protocols.html
    enum CodingKeys: CodingKey {
        case email
        case password
        case userName
        case nickName
        case imageURL
        case favorites
    }

    // 각각의 회원 정보는 고유한 아이디로 관리되어야 합니다.
    // UUID는 영문-숫자 혼합 형태의 랜덤한 아이디를 생성합니다.
    // 예. 123e4567-e89b-12d3-a456-426614174000
    // https://en.wikipedia.org/wiki/Universally_unique_identifier#:~:text=IEC%209834%2D8.-,Format,e89b%2D12d3%2Da456%2D426614174000
    var id = UUID()
    
    let email: String // 유저의 이메일 입니다. 중복 허용이 되지 않습니다.
    var password: String // 유저의 비밀번호 입니다.
    var userName: String // 유저의 실명입니다.
    var nickName: String // 닉네임입니다. 중복 허용이 되지 않습니다.
    var imageURL: String // "https" 형식의 이미지 url 입니다.
    var favorites: [Favorites] // 관심분야 선택 및 칭호 획득 여부를 관리하는 추가 struct 입니다. Favorites 형식의 배열 입니다.
}

struct Favorites: Codable, Hashable {
    var category: String // 관심분야 (SF심볼의 이름으로 저장합니다. 예. tshirt, fork.knife 등)
    var checked: Bool // 사용자가 선택한 관심분야
    var awarded: Bool // 선택한 관심분야에서의 칭호 획득 여부 (해당란이 true라면 칭호를 획득했다는 의미이고, 빨간 하트 모양이 관심분야 아이콘에 함께 표시 됩니다.)
}

// 🔥 UserJSON 의 형식 🔥
// json 파일은 하나의 배열([]) 안에서 작성 됩니다.
// 이후 key : value 형식으로 자료를 작성합니다. 예) key -> email, password / value -> "finishLine@naver.com", "1234"
// key는 String과 같이 "" 표시를 한 후 작성합니다. 예) "password" : "1234"
// UserData 의 형식과 동일하게 작성되어야 합니다. 예) email: String vs email: "finishLine@naver.com" (email 이라는 key 값과 String 형식을 모두 준수하고 있음)
// 🔥 🔥 🔥 🔥 🔥  저는 Favorites 의 checked 변수를 chekced로 적어서 고생했습니다. 주의합시다! 🔥 🔥 🔥 🔥 🔥

/*
[
  {
    "email": "finishLine@naver.com",
    "password": "1234",
    "userName": "Lee",
    "nickName": "SuperPower",
    "imageURL": "https://static.wikia.nocookie.net/pokemon/images/3/3f/%EC%9D%B4%EB%B8%8C%EC%9D%B4_%EA%B3%B5%EC%8B%9D_%EC%9D%BC%EB%9F%AC%EC%8A%A4%ED%8A%B8.png/revision/latest/scale-to-width-down/200?cb=20170405085011&path-prefix=ko",
    "favorites": [
      {
        "category": "tshirt",
        "checked": false,
        "awarded": false
      },
      {
        "category": "bed.double",
        "checked": true,
        "awarded": false
      },
      {
        "category": "fork.knife",
        "checked": false,
        "awarded": false
      },
      {
        "category": "desktopcomputer",
        "checked": false,
        "awarded": false
      },
      {
        "category": "gamecontroller",
        "checked": true,
        "awarded": false
      },
      {
        "category": "ellipsis.circle",
        "checked": false,
        "awarded": false
      }
    ]
  }
]
*/
