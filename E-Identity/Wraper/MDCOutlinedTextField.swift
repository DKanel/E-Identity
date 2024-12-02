//
//  MDCOutlinedTextField.swift
//  E-Identity
//
//  Created by Dimitris Kanellidis on 2/11/24.
//

import SwiftUI
import MaterialComponents

struct OutlinedTextField: UIViewRepresentable {
    @Binding var text: String?
    var image: UIImage?
    var trailingImage: UIImage?
    @Binding var error: String?
    var placeholder: String
    var isEditable: Bool?

    func makeUIView(context: Context) -> MDCOutlinedTextField {
        let textField = MDCOutlinedTextField()
        textField.label.text = placeholder
        textField.text = text
        textField.delegate = context.coordinator // Set the coordinator as the delegate
        textField.placeholder = placeholder // Sets the placeholder text
        textField.leadingView = UIImageView(image: image) // Optional: Add a leading view (icon)
        textField.leadingView?.tintColor = .black
        textField.leadingViewMode = .always
        textField.trailingView = UIImageView(image: trailingImage) // Optional: Add a leading view (icon)
        textField.trailingView?.tintColor = .black
        textField.trailingViewMode = .always
        textField.leadingAssistiveLabel.text = error
        textField.autocapitalizationType = .none
        if (textField.leadingAssistiveLabel.text != nil){
            textField.setNormalLabelColor(.red, for: .normal)
            textField.setNormalLabelColor(.red, for: .editing)
            textField.setFloatingLabelColor(.red, for: .normal)
            textField.setFloatingLabelColor(.red, for: .editing)
            textField.setOutlineColor(.red, for: .normal)
            textField.setOutlineColor(.red, for: .editing)
            textField.setLeadingAssistiveLabelColor(.red, for: .normal)
            textField.setLeadingAssistiveLabelColor(.red, for: .editing)
            textField.trailingView?.tintColor = .red
            textField.autocapitalizationType = .none
        }
       
        textField.isUserInteractionEnabled = isEditable ?? true
        return textField
    }

    func updateUIView(_ uiView: MDCOutlinedTextField, context: Context) {
        uiView.text = text // Bind the text property
        uiView.leadingAssistiveLabel.text = error
        if (uiView.leadingAssistiveLabel.text != nil){
            uiView.setNormalLabelColor(.red, for: .normal)
            uiView.setNormalLabelColor(.red, for: .editing)
            uiView.setFloatingLabelColor(.red, for: .normal)
            uiView.setFloatingLabelColor(.red, for: .editing)
            uiView.setOutlineColor(.red, for: .normal)
            uiView.setOutlineColor(.red, for: .editing)
            uiView.setLeadingAssistiveLabelColor(.red, for: .normal)
            uiView.setLeadingAssistiveLabelColor(.red, for: .editing)
//            uiView.trailingView?.tintColor = .red  
        }else{
            uiView.setNormalLabelColor(.black, for: .normal)
            uiView.setNormalLabelColor(.black, for: .editing)
            uiView.setFloatingLabelColor(.black, for: .normal)
            uiView.setFloatingLabelColor(.black, for: .editing)
            uiView.setOutlineColor(.black, for: .normal)
            uiView.setOutlineColor(.black, for: .editing)
            uiView.setLeadingAssistiveLabelColor(.black, for: .normal)
            uiView.setLeadingAssistiveLabelColor(.black, for: .editing)
            uiView.trailingView?.tintColor = .black
        }
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
