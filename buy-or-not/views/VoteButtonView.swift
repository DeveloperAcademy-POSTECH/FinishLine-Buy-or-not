//
//  VoteButtonView.swift
//  buy-or-not
//
//  Created by leejunmo on 2022/04/09.
//

import SwiftUI


struct ItemData {
    var option: [Options]
    var buttonState: [Bool]
    
    init(option: [Options]) {
        self.option = option
        buttonState = []
        for _ in option {
            
            buttonState.append(false)
            
        }
    }
    
    
    
}

struct VoteButtonView: View {
    
    @State var voteDone: Bool = false
    
    @State var itemData = ItemData(option: [Options(name: "루크", pressed: false), Options(name: "루크", pressed: false), Options(name: "루크", pressed: false)])
 
    
    func buttonTab(index: Int) {
        if itemData.buttonState[index] == true  {
            self.voteDone = true
        } else {
            // 토글
            for i in 0..<itemData.buttonState.count {
                itemData.buttonState[i] = false
            }

            self.itemData.buttonState[index] = true
            
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
                ForEach(0..<itemData.buttonState.count) { index in
                    Button {
                        withAnimation {
                            buttonTab(index: index)
                        }
                    } label: {
                        ZStack {
                            Rectangle().foregroundColor(itemData.buttonState[index] ? .blue : .clear).cornerRadius(10)
                            Text(itemData.buttonState[index] ? "한번 더 누르시면\n투표가 반영됩니다." : "\(index + 1)번").foregroundColor(.black)
                                .font(itemData.buttonState[index] ? .caption : .body)
                        }
                    }


                }
                
            }
            .frame(height: 40)
        }
    }
}

struct VoteButtonView_Previews: PreviewProvider {
    static var previews: some View {
        VoteButtonView()
    }
}
