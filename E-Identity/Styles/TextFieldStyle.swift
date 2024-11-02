//
//  TextField Style.swift
//  E-Identity
//
//  Created by Dimitris Kanellidis on 2/11/24.
//

import Foundation
import SwiftUI

struct OutlinedTextFieldStyle: TextFieldStyle {
    var padding: CGFloat = 10
    var width: CGFloat = 300
    
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .frame(width: width)
            .padding(padding)
    }
}
