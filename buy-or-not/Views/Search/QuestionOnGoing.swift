//
//  QuestionOnGoing.swift
//  buy-or-not
//
//  Created by Noah's Ark on 2022/04/07.
//

import SwiftUI

struct QuestionOnGoing: View {

    var searchText: String
    var data: QuestionItemManager
    
    var body: some View {
        ScrollView {
            ForEach(data.json) {feed in
                if feed.title.contains(searchText) {
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
