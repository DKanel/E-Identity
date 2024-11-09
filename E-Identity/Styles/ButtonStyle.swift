//
//  ButtonStyle.swift
//  E-Identity
//
//  Created by Dimitris Kanellidis on 2/11/24.
//

import Foundation
import SwiftUI

struct DarkBlueButtonStyle: ButtonStyle {
    var cornerRadius: CGFloat = 12
    var width: CGFloat = 150
    

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: width)
            .foregroundColor(.white)
            .padding()
            .background(Color.darkBlueButtonColor)
            .cornerRadius(cornerRadius)
    }
}

struct LightBlueButtonStyle: ButtonStyle {
    var cornerRadius: CGFloat = 12
    var width: CGFloat = 150
    

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: width)
            .foregroundColor(.black)
            .padding()
            .background(Color.lightBlueButtonColor)
            .cornerRadius(cornerRadius)
    }
}

struct CardStyleButton: ButtonStyle {
    var width: CGFloat = 180
    var height: CGFloat = 70
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: width, height: height)
            .foregroundStyle(.black)
            .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.lightBlueButtonColor)
                .shadow(color: .gray, radius: 2, x: 0, y: 2))
    }
    
}
