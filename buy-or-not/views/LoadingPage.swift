//
//  LoadingPage.swift
//  buy-or-not
//
//  Created by 한경준 on 2022/04/07.
//

import SwiftUI

struct LoadingPage: View {
    var body: some View {
        VStack() {
            Image("BuyOrNotLogo")
                .resizable()
                .frame(width: 100, height: 100)
                .padding(.vertical, 12.0)
            
            HStack() {
                ProgressView(value: 0.5)
                    .frame(width: 30, height: 30)
                    .progressViewStyle(CircularProgressViewStyle())
                    .scaleEffect(x: 1.25, y: 1.25, anchor: .center)
                Text("앱을 시작하고 있어요...")
                    .foregroundColor(.gray)
            }
            .padding(.vertical, 12.0)
        }
    }
}

struct LoadingPage_Previews: PreviewProvider {
    static var previews: some View {
        LoadingPage()
    }
}
