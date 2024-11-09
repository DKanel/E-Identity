//
//  ChosseLoginTypeController.swift
//  E-Identity
//
//  Created by Dimitris Kanellidis on 9/11/24.
//

import SwiftUI

struct ChooseLoginTypeController: View {
    var body: some View {
        ZStack{
            Color.mainBackgroundColor
            VStack{
                VStack{
                    Image("logo")
                        .resizable()
                        .frame(width: 80, height: 100)
                    Text("login_message".localized)
                        .bold()
                        .font(.title)
                    Text("choose_login_type_message".localized)
                        .fontWeight(.light)
                }
                VStack{
                    HStack{
                        Image("logo")
                            .resizable()
                            .frame(width: 80, height: 100)
                        NavigationLink {
                            
                        } label: {
                            Text("Click me")
                        }

                    }
                    HStack{
                        Image("logo")
                            .resizable()
                            .frame(width: 80, height: 100)
                        NavigationLink {
                            
                        } label: {
                            Text("Click me")
                        }
                    }
                    HStack{
                        Image("logo")
                            .resizable()
                            .frame(width: 80, height: 100)
                        NavigationLink {
                            
                        } label: {
                            Text("Click me")
                        }
                    }
                }
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    ChooseLoginTypeController()
}
