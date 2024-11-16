//
//  CheckEmailController.swift
//  E-Identity
//
//  Created by Dimitris Kanellidis on 9/11/24.
//

import SwiftUI

struct CheckEmailController: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        ZStack{
            Color.mainBackgroundColor
            VStack{
                VStack{
                    VStack(spacing: 100){
                        Image("logo")
                            .resizable()
                            .frame(width: 80, height: 100)
                        Image("check")
                            .resizable()
                            .frame(width: 70, height: 70)
                        Text("check_email_message".localized)
                            .multilineTextAlignment(.center)
                            .frame(width: 250)
                    }
                }
                Spacer()
                    .frame(height: 200)
                Button {
                    // To Do set action when login
                    dismiss()
                } label: {
                    Text("login_message".localized)
                        .textCase(.uppercase)
                    
                }
                .buttonStyle(DarkBlueButtonStyle())
            }
        }.ignoresSafeArea()
    }
}

#Preview {
    CheckEmailController()
}
