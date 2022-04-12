//
//  interestSellect.swift
//  buy-or-not
//
//  Created by 한경준 on 2022/04/07.
//

import SwiftUI

struct interestSellect: View {
    @Binding var isChecked: Bool
    @State var interestIcon: String = ""
    @State var interestTitle: String = ""
    @State var interestSubTitle: String = ""
    
    @State var checkboxInput: Bool = false
    
    
    
    var body: some View {
        HStack() {
            ZStack {
                Circle()
                    .strokeBorder()
                    .frame(width: 60.0, height: 60.0)
                    .foregroundColor(.gray)
                
                Image(systemName: interestIcon)
                    .font(.system(size: 24.0, weight: .regular))
                    .foregroundColor(.black)
                    .frame(width: 60, height: 60)
            }
            
            
            VStack() {
                Text(interestTitle)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .dynamicTypeSize(/*@START_MENU_TOKEN@*/.xLarge/*@END_MENU_TOKEN@*/)
                    .padding(.top, 6.0)
                Spacer()
                    .frame(height: 4.0)
                Text(interestSubTitle)
                    .fontWeight(.light)
                    .foregroundColor(Color.gray)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .dynamicTypeSize(/*@START_MENU_TOKEN@*/.small/*@END_MENU_TOKEN@*/)
                    .padding(.bottom, 6.0)
            }
            .frame(width: 210, height: 60, alignment: .center)
            
            Toggle(isOn: $isChecked) {
            }
            .padding(.bottom, 24.0)
            .toggleStyle(CheckBoxView(toggleColor: .black))
            .frame(width: 30, height: 60)
        }
        .padding(.vertical, 6.0)
    }
}
//
//struct interestSellect_Previews: PreviewProvider {
//
//    static var previews: some View {
//        interestSellect()
//    }
//}
//
