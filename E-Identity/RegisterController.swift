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
    @State var name: String = ""
    @State var surname: String = ""
    @State var email: String = ""
    @State var password: String = ""
    @State var validPassword: String = ""
    var body: some View {
        ZStack{
            Color.mainBackgroundColor
            ScrollView(showsIndicators: false){
                Spacer(minLength: 100)
                VStack{
                    Image("android studio")
                        .resizable()
                        .frame(width: 150)
                    Text(LocalizedStringKey("register_message"))
                        .font(.title)
                    OutlinedTextField(text: $name, placeholder: "name".localized)
                        .padding(.all)
                        .frame(width: 300)
                    OutlinedTextField(text: $surname, placeholder: "surname".localized)
                        .padding(.all)
                        .frame(width: 300)
                    OutlinedTextField(text: $email, placeholder: "email".localized)
                        .padding(.all)
                        .frame(width: 300)
                    OutlinedTextField(text: $password, placeholder: "password".localized)
                        .padding(.all)
                        .frame(width: 300)
                    OutlinedTextField(text: $validPassword, placeholder: "valid_password".localized)
                        .padding(.all)
                        .frame(width: 300)
                    Button {
                        //To Do validation for regester
                    } label: {
                        Text("register".localized.uppercased())
                    }
                    .buttonStyle(DarkBlueButtonStyle())
                }
            }
            .modifier(KeyboardAwareModifier())
        }
        .ignoresSafeArea()
    }
}

#Preview {
    RegisterController(name: "name string")
}
