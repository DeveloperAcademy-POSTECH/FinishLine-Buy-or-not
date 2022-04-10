//
//  VoteButtons.swift
//  buy-or-not
//
//  Created by Noah's Ark on 2022/04/07.
//

import SwiftUI


// Vote Buttons Sample on the basis of Bethev's form
struct VoteButtons: View {
    
    var data: [Options]
    // 옵션 최대 갯수 4개
    @State var buttonState: [Bool] = [false, false, false, false]
    @State var voteDone: Bool = false
    

    func buttonTab(index: Int, dataCount: Int) {
        
        //MARK: - 문제없음
        if buttonState[index] == true  {
            self.voteDone = true
        } else {
            // 토글
            for i in 0..<dataCount {
                if (i == index) {
                    self.buttonState[i] = true
                } else {
                    self.buttonState[i] = false
                }
            }
        }
    }
    
    var body: some View {
        if voteDone {
            ZStack (alignment:.leading) {
                RoundedRectangle(cornerRadius: 10).frame(height: 40).foregroundColor(Color.init(hex: "F2F2F7"))
                RoundedRectangle(cornerRadius: 10).frame(width: 300, height: 40).foregroundColor(Color.init(hex: "C7C7CC"))
                RoundedRectangle(cornerRadius: 10).frame(width: 250, height: 40).foregroundColor(Color.init(hex: "007AFF"))
                // 투표 현황 텍스트 추가되어야함
            }
        } else {
            HStack {
                ForEach (0..<data.count, id: \.self) { idx in
                    Button {
                        withAnimation {
                            buttonTab(index: idx, dataCount: data.count)
                            let fmt = ISO8601DateFormatter()
                            let date1 = fmt.date(from: "2017-08-06T19:20:42+0000")!
                            let date2 = fmt.date(from: "2020-08-06T19:20:46+0000")!
                            print(Calendar.current.dateComponents([.day], from: date1, to: date2).day!)
                            print(type(of: Calendar.current.dateComponents([.day], from: date1, to: date2).day))

                        }
                    } label: {
                        ZStack {
                            Rectangle().foregroundColor(buttonState[idx] ? .blue : .clear).cornerRadius(10)
                            Text(buttonState[idx] ? "한번 더 누르시면\n투표가 반영됩니다." : "\(data[idx].name)").foregroundColor(.black)
                                .font(buttonState[idx] ? .caption : .body)
                        }
                    }
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
