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
    var placeholder: String

    func makeUIView(context: Context) -> MDCOutlinedTextField {
        let textField = MDCOutlinedTextField()
        textField.label.text = placeholder
        textField.delegate = context.coordinator // Set the coordinator as the delegate
        textField.placeholder = placeholder // Sets the placeholder text
        textField.leadingView = UIImageView(image: UIImage(systemName: "person")) // Optional: Add a leading view (icon)
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
