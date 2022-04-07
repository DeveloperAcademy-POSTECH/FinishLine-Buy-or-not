//
//  VoteButtons.swift
//  buy-or-not
//
//  Created by Noah's Ark on 2022/04/07.
//

import SwiftUI


// Vote Buttons Sample on the basis of Bethev's form
struct VoteButtons: View {
//    @State private var buttonIsPressed1: Bool = false
//    @State private var buttonIsPressed2: Bool = false
//    @State private var buttonIsPressed3: Bool = false
    
    @State var sampleBoolean: Bool = false
    @State var voteDone: Bool = false
    
    var options: [Options]
        
    var body: some View {
        VStack {
            ForEach (options, id: \.self) { option in
                
                let data = option
                var pressed = data.pressed
                let name = data.name
                let t = type(of: data.pressed)
                let str = ["#00a8ff", "#9c88ff", "#f5f6fa", "#40739e", "#dcdde1", "#E6BA95", "#E4E9BE", "#A2B38B"]
                let indexRandom = Int.random(in: 0..<str.count)
                
                
                // 버튼 터치 잘 안됨.. 아래쪽 부분을 터치하면 인식 XXX
                Button(action: {
                    print("🐶 \(name): '\(pressed)' with typeof \(t)")
                    print("🐯 Original JSON Data: \(data)")
                    
                    // 버튼을 누르면 변경된 Bool 데이터를 백엔드로 전송
                    // 기존 Bool 데이터를 변동한다
                    
                    if pressed {
                        withAnimation{ voteDone = true }
                    } else {
                        pressed = !pressed
                    }
                    
                }) {
                    Text(
                        pressed
                            ? "한번 더 누르시면\n투표가 반영됩니다."
                            : "\(name)"
                        )
                            .foregroundColor(.black)
                            .font(pressed ? .caption : .body)
                            .frame(width: 300, height: 50, alignment: .center)
                            .background(Color(hex: "\(str[indexRandom])"))
                            .cornerRadius(10)
                }
            }
        }
    }
}

extension String {
    func createRandomStr(length: Int) -> String {
        let str = (0 ..< length).map{ _ in self.randomElement()! };
        return String(str)
    }
}
