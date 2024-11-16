//
//  LoginController.swift
//  E-Identity
//
//  Created by Dimitris Kanellidis on 2/11/24.
//

import SwiftUI
import MaterialComponents.MaterialTextControls_FilledTextAreas
import MaterialComponents.MaterialTextControls_FilledTextFields
import MaterialComponents.MaterialTextControls_OutlinedTextAreas
import MaterialComponents.MaterialTextControls_OutlinedTextFields

struct RegisterController: View {
    @Environment(\.dismiss) var dismiss
    @State var name: String?
    @State var surname: String?
    @State var email: String?
    @State var password: String?
    @State var validPassword: String?
    @State var nameError: String?
    @State var surnameError: String?
    @State var emailError: String?
    @State var passwordError: String?
    @State var validPasswordError: String?
    @State var isPresenting: Bool = false
    let viewModel = RegisterViewModel()
    var body: some View {
        ZStack{
            Color.mainBackgroundColor
            ScrollView(showsIndicators: false){
                Spacer(minLength: 100)
                VStack{
                    Image("logo")
                        .resizable()
                        .frame(width: 80, height: 100)
                    Text("register_message".localized)
                        .font(.title)
                    OutlinedTextField(text: $name,error: $nameError, placeholder: "name".localized)
                        .padding(.all)
                        .frame(width: 300)
                    OutlinedTextField(text: $surname, error: $surnameError, placeholder: "surname".localized)
                        .padding(.all)
                        .frame(width: 300)
                    OutlinedTextField(text: $email, error: $emailError, placeholder: "email")
                        .padding(.all)
                        .frame(width: 300)
                    OutlinedTextField(text: $password, error: $passwordError, placeholder: "password".localized)
                        .padding(.all)
                        .frame(width: 300)
                    OutlinedTextField(text: $validPassword, error: $validPasswordError, placeholder: "valid_password".localized)
                        .padding(.all)
                        .frame(width: 300)
                    Button {
                        var triggerNumber = 0
                        let errorArray: [Binding<String?>] = [$nameError,$surnameError,$emailError,$passwordError]
                        let nameLabelArray: [Binding<String?>] = [$name,$surname,$email,$password]
                        for i in 0...errorArray.count-1{
                            if viewModel.isEmptyValidation(text: nameLabelArray[i].wrappedValue){
                                errorArray[i].wrappedValue = "empty_message".localized
                                triggerNumber = 0
                            }else{
                                errorArray[i].wrappedValue = nil
                                triggerNumber += 1
                                if !viewModel.isValidPassword(text: password) {
                                    passwordError = "wrong_password_type".localized
                                    triggerNumber = 0
                                }
                                if !viewModel.isValidEmail(text: email){
                                    emailError = "wrong_type".localized
                                    triggerNumber = 0
                                }
                                
                            }
                        }
                        
                        if triggerNumber == 4{
                            isPresenting = true
                        }
                    } label: {
                        Text("register_message".localized)
                            .textCase(.uppercase)
                    }
                    .buttonStyle(DarkBlueButtonStyle())
                    Spacer()
                        .frame(height: 30)
                }
            }
            .modifier(KeyboardAwareModifier())
        }
        .ignoresSafeArea()
        .fullScreenCover(isPresented: $isPresenting, onDismiss: {
            dismiss()
        }, content: {

            CheckEmailController()
        })
            
        
    }
}

#Preview {
    RegisterController(name: "ass", surname: "ass", email: "www", password: "dwq", validPassword: "dsad")
}
