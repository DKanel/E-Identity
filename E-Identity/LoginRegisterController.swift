//
//  LoginRegisterController.swift
//  E-Identity
//
//  Created by Dimitris Kanellidis on 2/11/24.
//

import SwiftUI

struct LoginRegisterController: View {
    var body: some View {
        ZStack{
            Color.mainBackgroundColor
            VStack{
                Spacer(minLength: 150)
                VStack{
                    Text(LocalizedStringKey("wolcome_message"))
                    Image("android studio")
                        .resizable()
                        .frame(width: 100)
                    Text("e-Identity")
                        .bold()
                        .font(.title)
                }
                Spacer(minLength: 100)
                Button {
                    // To Do set action when login
                } label: {
                    Text(LocalizedStringKey("login_message"))
                        .frame(width: 150)
                        .foregroundStyle(.white)
                        .padding()
                        .background(Color.darkBlueButtonColor)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                Spacer(minLength: 30)
                Button {
                    // To Do set action when register
                } label: {
                    Text(LocalizedStringKey("register_message"))
                        .frame(width: 150)
                        .foregroundStyle(.white)
                        .padding()
                        .background(Color.lightBlueButtonColor)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                Spacer(minLength: 100)
                Image("android studio")
                    .resizable()
                    .frame(width: 200)
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    LoginRegisterController()
}
