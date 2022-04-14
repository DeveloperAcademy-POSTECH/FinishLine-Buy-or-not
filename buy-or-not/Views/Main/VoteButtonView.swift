//
//  VoteButtonView.swift
//  buy-or-not
//
//  Created by leejunmo on 2022/04/13.
//

import SwiftUI

struct VoteButtonView: View {
    
    var data: [Options]
    var fromWhere: Bool
    private let voteDoneColor = ["C7C7CC", "8A67E8"]
    // 옵션 최대 갯수 4개
    @Binding var buttonState: [Bool]
    
    @Binding var voteDone: Bool
    @Binding var mode_:Int
    
    func buttonTab(index: Int, dataCount: Int) {
        if buttonState[index] == true  {
            mode_ = -1
            withAnimation(Animation.easeOut(duration: 0.8)) {
                self.voteDone = true
            }
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
    
    func voteCountMaker() -> [Dictionary<String, Int>.Element] {
        var voteCountBox: [String: Int] = [:]
        
        for item in self.data {
            voteCountBox[item.name] = item.votes.count
        }
        
        return voteCountBox.sorted { $0.1 > $1.1 }
    }
    
    var body: some View {
        if voteDone || fromWhere {
            let sortedVoteCount: [Dictionary<String, Int>.Element] = voteCountMaker()
            let totalVotes: Int = sortedVoteCount.compactMap { $0.1 }.reduce(0, +)
            
            VStack (alignment: .center) {
                ForEach (0..<sortedVoteCount.count, id: \.self) { idx in
                    Text("\(idx+1)위 \(sortedVoteCount[idx].key) : \(sortedVoteCount[idx].value%totalVotes)표")
                }
            }
            
        } else {
            HStack(spacing : 0) {
                ForEach (0..<data.count, id: \.self) { idx in
                    if (idx != 0){
                        Divider()
                    }
                    Button {
                        mode_ = idx + 1
                        buttonTab(index: idx, dataCount: data.count)
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
