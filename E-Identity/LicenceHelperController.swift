//
//  DrivingLicenceHelperController.swift
//  E-Identity
//
//  Created by Dimitris Kanellidis on 30/11/24.
//

import SwiftUI
import SwiftyTesseract

struct LicenceHelperController: View {
    @State var isDriverPresenting = false
    @State private var recognizedText = ""
        
    let tesseract = Tesseract(languages: [.greekModern, .english])
    var body: some View {
        ZStack{
            Color.mainBackgroundColor
            VStack(){
                Image("driving licence")
                    .resizable()
                    .frame(width: 300, height: 200)
                    Spacer()
                    .frame(height: 80)
                HStack(){
                    Spacer()
                    Spacer()
                    Spacer()
                    Text("drivers_licence_helper".localized)
                        .frame(width: 400)
                        .multilineTextAlignment(.center)
                    Spacer()
                        Button{
                            DispatchQueue.main.async {
                            AppDelegate.orientationLock = UIInterfaceOrientationMask.portrait
                            UIDevice.current.setValue(UIInterfaceOrientation.landscapeRight.rawValue, forKey: "orientation")
                            UIViewController.attemptRotationToDeviceOrientation()
                                isDriverPresenting = true
                            }
                            
                        }label: {
                            Text("SCAN")
                        }
                        .buttonStyle(DarkBlueButtonStyleSmall())
                        Spacer()
                            .frame(width: 50)
                    }
            }
        }
        .ignoresSafeArea()
        .fullScreenCover(isPresented: $isDriverPresenting, onDismiss: {
        }, content: {
            CameraScannerView(scannedText: $recognizedText)
        })
        .onAppear(){
            // Forcing the rotation to portrait
            DispatchQueue.main.async {
            AppDelegate.orientationLock = UIInterfaceOrientationMask.landscape
            UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
            UIViewController.attemptRotationToDeviceOrientation()
            }
        }
    }
}

#Preview {
    LicenceHelperController(isDriverPresenting: false)
}
