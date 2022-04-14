//
//  AllPosts.swift
//  buy-or-not
//
//  Created by Noah's Ark on 2022/04/07.
//

import SwiftUI

struct AllPosts: View {
    
    var searchText: String
    var data: QuestionItemManager
    
    @State var previewImg: String = "default"
    @State var previewState: Bool = false
    @State var fromWhere: Bool = false

    
    var body: some View {
        ScrollView {
            ForEach (data.json) {feed in
                let passedTime = (DateCalculator(originatedDate:feed.timeStamp).dateDiff.day! > 1) ? DateCalculator(originatedDate:feed.timeStamp).dateDiff.day! : DateCalculator(originatedDate:feed.timeStamp).dateDiff.hour!

                if feed.title.contains(searchText) {
                    QuestionItem(
                        author: feed.author,
                        title: feed.title,
                        category: feed.category,
                        items: feed.items,
                        timestamp: passedTime,
                        previewImg: $previewImg,
                        previewState: $previewState,
                        fromWhere: $fromWhere
                    )
                }
            }
        }
    }
}
