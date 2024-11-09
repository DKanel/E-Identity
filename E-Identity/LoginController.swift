//
//  LoginController.swift
//  E-Identity
//
//  Created by Dimitris Kanellidis on 9/11/24.
//

import SwiftUI

struct LoginController: View {
    @Binding var loginType: Int
    @Binding var email: String
    @Binding var isVisible: Bool
    @State var buttonLabel = "next"
    var body: some View {
        ZStack{
            Color.mainBackgroundColor
            VStack{
                Image("logo")
                    .resizable()
                    .frame(width: 80, height: 100)
                VStack{
                    OutlinedTextField(text: $email, image: UIImage(systemName: "envelope"), placeholder: "email".localized, isEditable: false)
                        .padding(.all)
                        .frame(width: 300,height: 100)
                    if isVisible{
                        VStack(alignment:.leading){
                            OutlinedTextField(text: $email, image: UIImage(systemName: "lock"),trailingImage: UIImage(systemName: "eye.fill"), placeholder: "password".localized)
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
                    NavigationLink(destination: CheckEmailController()) {
                        Text(buttonLabel)
                            .textCase(.uppercase)
                    }
                    .buttonStyle(DarkBlueButtonStyle())
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
        .onAppear(){
            if isVisible{
                buttonLabel = "login_message".localized
            } else {
                buttonLabel = "next".localized
            }
        
        }
        .ignoresSafeArea()
    }
}

#Preview {
    LoginController(loginType: .constant(1), email: .constant("Temp email"), isVisible: .constant(true), buttonLabel: "next")
}
