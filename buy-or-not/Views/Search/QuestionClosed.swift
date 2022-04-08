//
//  QuestionClosed.swift
//  buy-or-not
//
//  Created by Noah's Ark on 2022/04/07.
//

import SwiftUI

struct QuestionClosed: View {
    
    var data: QuestionItemManager
    
    var body: some View {
        ScrollView {
            Text("finishLine@naver.com 작성글 모아보기")
            
            ForEach(data.json) {feed in
                if feed.author.compare("finishLine@naver.com") == .orderedSame {
                    Feed(
                        title: feed.title,
                        author: feed.author,
                        votes: feed.votes,
                        comments: feed.comments,
                        imageURL: feed.imageURL,
                        options: feed.options
                    )
                        .frame(width: 410, alignment: .center)
                }
            }

        }
    }
}
