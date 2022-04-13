//
//  QuestionItem.swift
//  buy-or-not
//
//  Created by leejunmo on 2022/04/13.
//

import SwiftUI

struct QuestionItem: View {
    
    var author: String
    var title: String
    var category: String
    var items: [Options]
    var timestamp: Int
    
    
    @Binding var previewImg: String
    @Binding var previewState: Bool
    @Binding var fromWhere: Int
    
    @State private var mode: Int = -1
    
    func voteCount() -> Int {
        var c = 0
        for i in items {
            c += i.votes.count
        }
        return c
    }
    
    var body: some View {
        
        VStack(alignment:.leading) {
            
            if (mode == -1) {
                HStack {
                    ZStack {
                        // 보더적용
                        RoundedRectangle(cornerRadius: 20)
                            .strokeBorder(lineWidth: 1)
                            .foregroundColor(Color(hex: "E5E5EA"))
                            .frame(width: 116, height: 116)
                        
                        // 이미지 크기 보정 적용
                        AsyncImage(url: URL(string: items[0].imageURL)) { phase in
                            switch phase {
                            case .empty:
                                Text("이미지 없음")
                            case .success(let image):
                                image.resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(maxWidth: 116, maxHeight: 116)
                            case .failure:
                                Image(systemName: "photo")
                            @unknown default:
                                Text("이미지 없음")
                            }
                        }
                        .frame(width: 116, height: 116)
                        .cornerRadius(20)
                        .aspectRatio(contentMode: .fit)
                        .onTapGesture {
                            previewImg = items[0].imageURL
                            previewState.toggle()
                        }
                    }
                    Spacer()
                        .frame(width: 12)
                    
                    VStack(alignment:.leading) {
                        Text("\(title)")
                            .font(.system(size: 18, weight: .regular))
                        Spacer()
                        HStack {
                            Text(author)
                                .lineLimit(1)
                            Spacer()
                            if(timestamp > 364){
                                Text("\(timestamp/365)년 전")
                            } else if( timestamp>0){
                                Text("\(timestamp)일 전")
                            } else if(timestamp > -59){
                                Text("\(-timestamp)분 전")
                            } else {
                                Text("\(-timestamp/60)시간 전")
                            }
    
                            Text (//
                                "\(Image(systemName: "checkmark.square"))\(voteCount())"
                            )
                        }
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.gray)
                        
                        
                    }
                }
                .animation(.easeIn, value: 1)
            } else{
                HStack {
                    ZStack {
                        // 보더적용
                        RoundedRectangle(cornerRadius: 20)
                            .strokeBorder(lineWidth: 1)
                            .foregroundColor(Color(hex: "E5E5EA"))
                            .frame(width: 116, height: 116)
                        
                        // 이미지 크기 보정 적용
                        AsyncImage(url: URL(string: items[mode].imageURL))
                        { phase in
                            switch phase {
                            case .empty:
                                Text("이미지 없음")
                            case .success(let image):
                                image.resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(maxWidth: 116, maxHeight: 116)
                            case .failure:
                                Image(systemName: "photo")
                            @unknown default:
                                Text("이미지 없음")
                            }
                        }
                        .frame(width: 116, height: 116)
                        .cornerRadius(20)
                        .onTapGesture {
                            previewImg = items[mode].imageURL //이부분을 수정해야함.
                            previewState.toggle()
                        }
                    }
                    Spacer()
                    
                    VStack(alignment:.leading) {
                        HStack {
                            Text(items[mode].name)
                                .font(.system(size: 18, weight: .regular))
                            Spacer()
                            Text (
                                "\(Image(systemName: "xmark"))"
                            )
                            .onTapGesture {
                                mode=0
                            }
                        }
                        
                        Spacer()
                        
                        HStack {
                            Text(items[mode].cost)
                                .foregroundColor(.gray)
                            
                            Spacer()
                            
                            LinkURL( url: items[mode].itemURL)
                        }
                        .font(.system(size: 18, weight: .bold))
                    }
                }
                .animation(.easeIn, value: 1)
            }
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .strokeBorder(lineWidth: 1)
                    .frame(height: 40)
                    .foregroundColor(Color.init(hex: "E5E5EA"))
                if fromWhere == 0 {
                    VoteButtonView(data: items, fromWhere: false, mode_:self.$mode)
                } else {
                    VoteButtonView(data: items, fromWhere: true, mode_:self.$mode)
                }
            }.frame(height: 40)
            Spacer()
                .frame(height: 17.0)
        }
        .frame(height: 177.5)
        Divider()
            .padding(.bottom, 17.0)
    }
}
