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
            .foregroundColor(.white)
            .padding()
            .background(Color.lightBlueButtonColor)
            .cornerRadius(cornerRadius)
    }
}
