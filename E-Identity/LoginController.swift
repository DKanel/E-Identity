//
//  LoginController.swift
//  E-Identity
//
//  Created by Dimitris Kanellidis on 9/11/24.
//

import SwiftUI

struct LoginController: View {
    @State var email: String?
    @State var password: String?
    @Binding var isVisible: Bool
    @State var emailError: String?
    @State var passwordError: String?
    @State var buttonLabel = "next"
    @State var isPresentingSuccessLogin = false
    @State var isPresentingFailureLogin = false
    @State var isVerified = false
    @State var showAlert = false
    @State var alertTitle: String?
    var body: some View {
        ZStack{
            Color.mainBackgroundColor
            ScrollView{
                Spacer(minLength: 100)
                VStack{
                    Image("logo")
                        .resizable()
                        .frame(width: 80, height: 100)
                    VStack{
                        OutlinedTextField(text: $email, image: UIImage(systemName: "envelope"), error: $emailError, placeholder: "email", isEditable: true)
                            .padding(.all)
                            .frame(width: 300,height: 100)
                        if isVisible{
                            VStack(alignment:.leading){
                                OutlinedTextField(text: $password, image: UIImage(systemName: "lock"),trailingImage: UIImage(systemName: "eye.fill"), error: $passwordError, placeholder: "password".localized)
                                    .padding(.all)
                                    .frame(width: 300,height: 100)
                                Text("forgot_password".localized)
                                    .fontWeight(.light)
                                    .frame(alignment: .leading)
                                    .padding(.leading)
                                Spacer()
                                    .frame(height: 50)
                            }
                        }
                        Button{
                            let viewModel = GenericViewModel()
                            if !viewModel.isValidEmail(text: email){
                                emailError = "wrong_type".localized
                            } else {
                                if viewModel.isEmptyValidation(text: email) {
                                    emailError = "empty_message".localized
                                } else {
                                    emailError = nil
                                }
                            }
                            if !viewModel.isValidPassword(text: password){
                                passwordError = "wrong_password_type".localized
                            } else {
                                if viewModel.isEmptyValidation(text: password){
                                    passwordError = "empty_message".localized
                                } else {
                                    passwordError = nil
                                }
                            }
                            if emailError == nil && passwordError == nil {
                                let api = APIClient()
                                api.login(email: email ?? "", password: password ?? "", token: Constants().token){ response in
                                    switch response{
                                    case .success(let loginResponse):
                                        if loginResponse.registrationStatus == "unverified"{
                                            isPresentingFailureLogin = true
                                            isPresentingSuccessLogin = false
                                        }else if loginResponse.registrationStatus == "verified"{
                                            isPresentingFailureLogin = false
                                            isPresentingSuccessLogin = true
                                        }
                                    case .failure(let error):
                                        print("error:\(error)")
                                        alertTitle = error.localizedDescription
                                        showAlert = true
                                    }
                                    
                                }
                            }
                            
                            
                        } label: {
                            Text(buttonLabel)
                        }
                        .buttonStyle(DarkBlueButtonStyle())
                        .alert(isPresented: $showAlert) {
                            Alert(
                                title: Text(alertTitle ?? ""),
                                dismissButton: .default(Text("OK"))
                            )
                        }
                        Spacer()
                            .frame(height: 20)
                        HStack{
                            Text("new_user_message".localized)
                                .fontWeight(.light)
                            NavigationLink {
                                RegisterController()
                            } label: {
                                Text("clickable_new_user_message".localized)
                                    .fontWeight(.light)
                                    .foregroundStyle(.blue)
                            }
                        }
                    }
                }
            }
            .modifier(KeyboardAwareModifier())
        }
        .onAppear(){
            if isVisible{
                buttonLabel = "login_message".localized
            } else {
                buttonLabel = "next".localized
            }
        }
        .ignoresSafeArea()
        .fullScreenCover(isPresented: $isPresentingFailureLogin, onDismiss: {
        }, content: {
            CheckEmailController()
        })
        .fullScreenCover(isPresented: $isPresentingSuccessLogin, onDismiss: {
        }, content: {
            SelectValidationController()
        })
    }
}

#Preview {
    LoginController( isVisible: .constant(true), buttonLabel: "next", alertTitle: "aaa")
}
