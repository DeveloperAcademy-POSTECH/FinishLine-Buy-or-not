//
//  CheckBoxView.swift
//  buy-or-not
//
//  Created by 한경준 on 2022/04/07.
//

import Foundation
import SwiftUI

struct CheckBoxView: ToggleStyle {
    
    @State var toggleColor: Color

    func makeBody(configuration: Self.Configuration) -> some View {

        return HStack {
            configuration.label

            Image(systemName: configuration.isOn ? "checkmark.square" : "square")
                .resizable()
                .frame(width: 18, height: 18)
                .foregroundColor(toggleColor)
                .font(.system(size: 18, weight: .semibold, design: .default))
                .foregroundColor(.black)
        }
        .onTapGesture { configuration.isOn.toggle() }

    }
}
