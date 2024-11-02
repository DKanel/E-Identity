//
//  KeyboardModifier.swift
//  E-Identity
//
//  Created by Dimitris Kanellidis on 2/11/24.
//

import Foundation
import SwiftUI
import Combine

// Custom View Modifier to adjust for keyboard
struct KeyboardAwareModifier: ViewModifier {
    @State private var keyboardHeight: CGFloat = 0

    func body(content: Content) -> some View {
        content
            .padding(.bottom, keyboardHeight)
            .onReceive(Publishers.keyboardHeight) { height in
                self.keyboardHeight = height
            }
    }
}

// Extension to observe keyboard notifications
extension Publishers {
    static var keyboardHeight: AnyPublisher<CGFloat, Never> {
        let willShow = NotificationCenter.default
            .publisher(for: UIResponder.keyboardWillShowNotification)
            .map { notification -> CGFloat in
                guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return 0 }
                return keyboardFrame.cgRectValue.height
            }
        
        let willHide = NotificationCenter.default
            .publisher(for: UIResponder.keyboardWillHideNotification)
            .map { _ in CGFloat(0) }

        return willShow.merge(with: willHide)
            .eraseToAnyPublisher()
    }
}
