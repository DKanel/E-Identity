//
//  SelectValidationController.swift
//  E-Identity
//
//  Created by Dimitris Kanellidis on 5/11/24.
//

import SwiftUI

struct SelectValidationController: View {
    let isImagesVisible = false
    let arrayOfValidationTypes: [String] = ["E1", "Δίπλωμα οδήγησης", "Διαβατήριο", "Ταυτότητα"]
    @State var isDrivingLicenceSelected: Bool = false
    @State var isPassport: Bool = false
    var body: some View {
        ZStack{
            Color.mainBackgroundColor
            VStack(spacing: 100){
                VStack(spacing: 30){
                    Image("logo")
                        .resizable()
                        .frame(width: 80, height: 100)
                    Text("select_validation_message".localized)
                        .font(.title)
                }
                VStack(spacing: 20){
                    ForEach(arrayOfValidationTypes, id: \.self){ validationType in
                        Button {
                            switch validationType{
                            case "Δίπλωμα οδήγησης":
                                print("driving licence pressed")
                                isDrivingLicenceSelected = true
                            case "E1":
                                print("E1 pressed")
                            case "Διαβατήριο":
                                print("Passaport pressed")
                                isPassport = true
                            case "Ταυτότητα":
                                print("ID pressed")
                            default:
                                print("default pressed")
                            }
                        } label: {
                            HStack{
                                Text(validationType)
                                    .frame(minWidth: 80, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                                    .multilineTextAlignment(.center)
                                    .font(.custom("", size: 14))
                                if isImagesVisible{
                                    HStack{
                                        Image("tick")
                                        Image("bin")
                                    }
                                }
                            }
                            .padding(.horizontal)
                            
                        }
                        .buttonStyle(CardStyleButton())
                    }
                }
                VStack{
                    Text("change_info".localized)
                        .fontWeight(.light)
                        .underline()
                        
                }
            }
        }
        .onAppear(){
            let api = APIClient()
            let loginToken = UserDefaults.standard.value(forKey: "LOGINTOKEN") as! String
            api.getUserDetails(token: Constants().token, loginToken: loginToken)
        }
        .ignoresSafeArea()
        .fullScreenCover(isPresented: $isDrivingLicenceSelected, onDismiss: {
        }, content: {
            LicenceHelperController()
        })
        .fullScreenCover(isPresented: $isPassport, onDismiss: {
        }, content: {
            PassportHelperController()
        })
    }
}

#Preview {
    SelectValidationController()
}
