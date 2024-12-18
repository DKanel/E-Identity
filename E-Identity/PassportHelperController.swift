//
//  E-Identity
//
//  Created by Dimitris Kanellidis on 30/11/24.
//

import SwiftUI

struct PassportHelperController: View {
    @State var isDriverPresenting = false
    @State private var recognizedName: String = ""
    @State private var recognizedSurname: String = ""
    @State private var isScannerPresented = false
    
    var body: some View {
        ZStack{
            Color.mainBackgroundColor
            VStack(){
                Image("passport image")
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
            ScannerView(onRecognizedText: processRecognizedText)
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
    func processRecognizedText(_ text: String) {
        parsePassport(text)
    }
    
    func parsePassport(_ text: String) {
        let lines = text.split(separator: "\n").map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
        print("Parsed Lines: \(lines)")
        
        for i in 0..<lines.count {
            if lines[i].hasPrefix("1.") { // Name line
                let components = lines[i + 1].split(separator: " ")
                if let latinName = components.last { // Latin name is usually last in this line
                    recognizedSurname = String(latinName)
                }else{
                    recognizedSurname = ""
                }
            }
            
            if lines[i].hasPrefix("2.") { // Surname line
                let components = lines[i + 1].split(separator: " ")
                if let latinSurname = components.last { // Latin surname is usually last in this line
                    recognizedName = String(latinSurname)
                }else{
                    recognizedName = ""
                }
            }
            print("Name: \(recognizedName) and Surname: \(recognizedSurname)")
            if recognizedName != "" && recognizedSurname != ""{
                let loginToken = UserDefaults.standard.value(forKey: "LOGINTOKEN") as! String
                let api = APIClient()
                api.postLicenseRequest(name: recognizedName, surname: recognizedSurname, loginToken: loginToken, token: Constants().token)
            }
        }
    }
}

#Preview {
    LicenceHelperController(isDriverPresenting: false)
}

