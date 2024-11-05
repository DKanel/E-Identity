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
                        Text("welcome_message".localized)
                        Image("logo")
                            .resizable()
                            .frame(width: 80, height: 100)
                        Text("e-Identity")
                            .bold()
                            .font(.title)
                    }
                    Spacer()
                    VStack(spacing: 30){
                        Button {
                            // To Do set action when login
                        } label: {
                            Text("login_message".localized)
                        }
                        .buttonStyle(DarkBlueButtonStyle())
                        NavigationLink(destination: RegisterController()) {
                            Text("register_message".localized)
                        }
                        .buttonStyle(LightBlueButtonStyle())
                    }
                    Spacer(minLength: 100)
                    Image("espa_banner")
                        .resizable()
                        .frame(height: 70)
                        .padding(.bottom).padding(.init(top: 0, leading: 0, bottom: 10, trailing: 0))
                }
            }
            .ignoresSafeArea()
        }
    }
}

#Preview {
    LoginRegisterController()
}
