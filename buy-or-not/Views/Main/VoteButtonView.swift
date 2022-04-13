//
//  VoteButtonView.swift
//  buy-or-not
//
//  Created by leejunmo on 2022/04/13.
//

import SwiftUI

struct VoteButtonView: View {
    
    var data: [Options]
    // 옵션 최대 갯수 4개
    @State var buttonState: [Bool] = [false, false, false, false]
    @State var voteDone: Bool = false
    
    @Binding var mode_:Int
    
    func buttonTab(index: Int, dataCount: Int) {
        if buttonState[index] == true  {
            mode_ = -1
            self.voteDone = true
        } else {
            // 토글
            for i in 0..<dataCount {
                if (i == index) {
                    self.buttonState[i] = true
                    mode_ = i
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
                RoundedRectangle(cornerRadius: 10).frame(width: 250, height: 40).foregroundColor(Color.init(hex: "8A67E8"))
                // 투표 현황 텍스트 추가되어야함
            }
        } else {
            HStack(spacing : 0) {
                ForEach (0..<data.count, id: \.self) { idx in
                                            if (idx != 0){
                                                Divider()
                                            }
                    Button {
                        withAnimation {
                            mode_ = idx + 1
                            buttonTab(index: idx, dataCount: data.count)
                        }
                    } label: {
                        ZStack {
                            Rectangle()
                                .foregroundColor(buttonState[idx] ? Color(hex: "8A67E8") : .clear)
                                .cornerRadius(10)
                            
                            Text(buttonState[idx] ? "투표하기" : data[idx].name)
                                .foregroundColor(buttonState[idx] ? Color.white :Color.black)
                                .font(.body)
                        }

                    }
                }
            }
        }
    }
}
