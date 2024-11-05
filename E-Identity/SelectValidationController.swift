//
//  SelectValidationController.swift
//  E-Identity
//
//  Created by Dimitris Kanellidis on 5/11/24.
//

import SwiftUI

struct SelectValidationController: View {
    let arrayOfValidationTypes: [String] = ["E1", "Δίπλωμα οδήγησης", "Διαβατήριο", "Ταυτότητα"]
    var body: some View {
        ZStack{
            Color.mainBackgroundColor
            VStack(spacing: 100){
                VStack{
                    Image("logo")
                        .resizable()
                        .frame(width: 80, height: 100)
                    Text("select_validation_message".localized)
                        .font(.title)
                }
                VStack(spacing: 20){
                    ForEach(arrayOfValidationTypes, id: \.self){ validationType in
                        Button {
                            
                        } label: {
                            HStack{
                                Text(validationType)
                                    .frame(minWidth: 80, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                                    .multilineTextAlignment(.center)
                                    .font(.custom("", size: 14))
                                HStack{
                                    Image("tick")
                                    Image("bin")
                                }
                            }
                            .padding(.horizontal)
                            
                        }
                        .buttonStyle(CardStyleButton())
                    }
                }
                VStack{
                    Text("change_info")
                }
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    SelectValidationController()
}
