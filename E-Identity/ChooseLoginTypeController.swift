//
//  ChosseLoginTypeController.swift
//  E-Identity
//
//  Created by Dimitris Kanellidis on 9/11/24.
//

import SwiftUI

struct ChooseLoginTypeController: View {
    @State var isVisible: Bool = true
    var body: some View {
        ZStack{
            Color.mainBackgroundColor
            VStack{
                Spacer()
                VStack{
                    Image("logo")
                        .resizable()
                        .frame(width: 80, height: 100)
                    Text("login_message".localized)
                        .font(.title)
                    Spacer()
                        .frame(height: 10)
                    Text("choose_login_type_message".localized)
                        .fontWeight(.light)
                }
                Spacer()
                VStack(spacing: 60){
                    HStack{
                        Image("Happy")
                            .resizable()
                            .frame(width: 50, height: 50)
                        NavigationLink {
                            
                        } label: {
                            Text("login_with_face_message".localized)
                                .foregroundStyle(.black)
                        }
                        .frame(width: 200, height: 10)
                        .padding()
                        .overlay(
                            Rectangle()
                                .stroke(Color.black, lineWidth: 1))

                    }
                    HStack{
                        Image("At sign")
                            .resizable()
                            .frame(width: 50, height: 50)
                        NavigationLink {
                            LoginController(isVisible: $isVisible)
                        } label: {
                            Text("login_with_email_message".localized)
                                .foregroundStyle(.black)
                        }
                        .frame(width: 200, height: 10)
                        .padding()
                        .overlay(
                            Rectangle()
                                .stroke(Color.black, lineWidth: 1))
                    }
                    HStack{
                        Image("Hand")
                            .resizable()
                            .frame(width: 50, height: 50)
                        NavigationLink {
                            
                        } label: {
                            Text("login_with_hand_message".localized)
                                .foregroundStyle(.black)
                        }
                        .frame(width: 200, height: 10)
                        .padding()
                        .overlay(
                            Rectangle()
                                .stroke(Color.black, lineWidth: 1))
                    }
                }
                Spacer()
                Image("espa_banner")
                    .resizable()
                    .frame(height: 70)
                    .padding(.bottom).padding(.init(top: 0, leading: 0, bottom: 10, trailing: 0))
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    ChooseLoginTypeController()
}
