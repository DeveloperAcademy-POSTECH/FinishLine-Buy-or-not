//
//  UserManager.swift
//  buy-or-not
//
//  Created by Noah's Ark on 2022/04/08.
//

import Foundation

// UserJSON 파일을 읽은 후, 확인된 데이터를 UserData 형식의 그릇에 담아줍니다.
// 🔥  주로 사용되던 struct가 아닌 class를 사용합니다. 🔥
// 해당 class는 ObservableObject 를 준수합니다. (ObservableObject : https://developer.apple.com/documentation/combine/observableobject)
// ObservableObject를 준수하는 class는 일종의 감시 대상이 됩니다.
// 이후 해당 class 내에 상황에 따라 내용이 변경되어야 할 변수가 있다면 @Published 함께 선언해줍니다. (https://nsios.tistory.com/120)
class UserManager: ObservableObject {
    
    // 해당 변수는 이후에 변경이 될 가능성이 있으므로 @Published를 함께 선언합니다.
    // (예. 새로운 유저가 가입할 시, 기존 유저가 탈퇴할 시, 누군가 닉네임을 변경할 시 등.)
    @Published var json = [UserData]()
    
    // class를 선언하게 되면 init (Initializer) 을 함께 선언해주어야 합니다.
    // class 가 선언되었을 때 가장 처음 해야할 일을 기재합니다. (변수 할당, 함수 실행 등.)
    // https://docs.swift.org/swift-book/LanguageGuide/Initialization.html
    init() {
        // load라는 함수가 실행되도록 합니다.
        load()
    }
    
    // UserJSON 파일을 읽은 후 해당 데이터가 상기 json 이라는 변수에 할당될 수 있도록 합니다.
    func load() {
        // guard 는 if와 유사한데, 조건이 맞지 않으면 앱을 종료 시키도록 문법이 구성되었습니다.
        // 때문에, 반드시 return이나 throw를 해주어야 합니다. 반대로 말하면 함수 내부에서 사용하도록 만들어진 구문입니다.
        guard let url = Bundle.main.url(forResource: "UserJSON", withExtension: "json")
                // Bundle.main.url 이라는 구문을 통해 UserJSON 파일을 읽은 결과를 url 변수에 할당하는 것
        else {
            // 상기 로직이 실패한다면 메세지를 print하고 return을 통해 앱을 종료합니다.
            print("JSON file not found")
            return
        }
        
        // 훔쳐온 코드.. 공부 중..
        let data = try? Data(contentsOf: url)
        let results = try? JSONDecoder().decode([UserData].self, from: data!)
        
        // 변환이 완료된 데이터를 기존 json 변수에 할당. 현재 json 변수는 class 내부에 존재해야 하므로
        // 구분을 위해 self. 를 추가 선언
        self.json = results!
    }
}
