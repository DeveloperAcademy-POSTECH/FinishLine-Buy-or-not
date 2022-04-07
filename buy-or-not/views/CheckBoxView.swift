//
//  CheckBoxView.swift
//  buy-or-not
//
//  Created by 한경준 on 2022/04/07.
//

import Foundation
import SwiftUI

struct CheckBoxView: ToggleStyle {

    func makeBody(configuration: Self.Configuration) -> some View {

        return HStack {
            configuration.label

            Image(systemName: configuration.isOn ? "checkmark.square" : "square")
                .resizable()
                .frame(width: 24, height: 24)
                .foregroundColor(configuration.isOn ? .gray : .gray)
                .font(.system(size: 20, weight: .light, design: .default))
                .foregroundColor(.gray)
        }
        .onTapGesture { configuration.isOn.toggle() }

    }
}
