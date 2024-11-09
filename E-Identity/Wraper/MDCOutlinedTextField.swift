//
//  MDCOutlinedTextField.swift
//  E-Identity
//
//  Created by Dimitris Kanellidis on 2/11/24.
//

import SwiftUI
import MaterialComponents

struct OutlinedTextField: UIViewRepresentable {
    @Binding var text: String
    var image: UIImage?
    var trailingImage: UIImage?
    var error: String?
    var placeholder: String
    var isEditable: Bool?

    func makeUIView(context: Context) -> MDCOutlinedTextField {
        let textField = MDCOutlinedTextField()
        textField.label.text = placeholder
        textField.delegate = context.coordinator // Set the coordinator as the delegate
        textField.placeholder = placeholder // Sets the placeholder text
        textField.leadingView = UIImageView(image: image) // Optional: Add a leading view (icon)
        textField.leadingView?.tintColor = .black
        textField.leadingViewMode = .always
        textField.trailingView = UIImageView(image: trailingImage) // Optional: Add a leading view (icon)
        textField.trailingView?.tintColor = .black
        textField.trailingViewMode = .always
        textField.leadingAssistiveLabel.text = error
        textField.isUserInteractionEnabled = isEditable ?? true
        return textField
    }

    func updateUIView(_ uiView: MDCOutlinedTextField, context: Context) {
        uiView.text = text // Bind the text property
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UITextFieldDelegate {
        var parent: OutlinedTextField

        init(_ parent: OutlinedTextField) {
            self.parent = parent
        }

        func textFieldDidChangeSelection(_ textField: UITextField) {
            if let text = textField.text {
                parent.text = text // Update the binding whenever the text changes
            }
        }
    }
}
