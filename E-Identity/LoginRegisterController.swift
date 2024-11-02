//
//  LoginRegisterController.swift
//  E-Identity
//
//  Created by Dimitris Kanellidis on 2/11/24.
//

import SwiftUI

struct LoginRegisterController: View {
    @State private var showFullScreen = false
    var body: some View {
        NavigationView{
            ZStack{
                Color.mainBackgroundColor
                VStack{
                    Spacer(minLength: 150)
                    VStack{
                        Text("wolcome_message".localized)
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
                        Text("login_message".localized)
                    }
                    .buttonStyle(DarkBlueButtonStyle())
                    Spacer(minLength: 30)
                    NavigationLink(destination: RegisterController()) {
                        Text("register_message".localized)
                    }
                    .buttonStyle(LightBlueButtonStyle())
                    Spacer(minLength: 100)
                    Image("android studio")
                        .resizable()
                        .frame(width: 200)
                }
            }
            .ignoresSafeArea()
        }
    }
}

#Preview {
    LoginRegisterController()
}
