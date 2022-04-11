//
//  interestSellect.swift
//  buy-or-not
//
//  Created by 한경준 on 2022/04/07.
//

import SwiftUI

struct interestSellect: View {

    @State var interestIcon: String = ""
    @State var interestTitle: String = ""
    @State var interestSubTitle: String = ""
    
    @State var checkboxInput: Bool = false

    var body: some View {
        HStack() {
            Image(systemName: interestIcon)
                .font(.system(size: 36.0, weight: .regular))
                .foregroundColor(Color(hex: "7E3CC2"))
                .frame(width: 60, height: 60)
                
            
            VStack() {
                Text(interestTitle)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .dynamicTypeSize(/*@START_MENU_TOKEN@*/.xLarge/*@END_MENU_TOKEN@*/)
                    .padding(.top, 6.0)
                Spacer()
                Text(interestSubTitle)
                    .fontWeight(.light)
                    .foregroundColor(Color.gray)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .dynamicTypeSize(/*@START_MENU_TOKEN@*/.small/*@END_MENU_TOKEN@*/)
                    .padding(.bottom, 6.0)
            }
            .frame(width: 210, height: 60, alignment: .center)
            
            Toggle(isOn: $checkboxInput) {
            }
                .toggleStyle(CheckBoxView())
                .frame(width: 30, height: 60)
        }
        .padding(.vertical, 6.0)
    }
}

struct interestSellect_Previews: PreviewProvider {

    static var previews: some View {
        interestSellect()
    }
}
