//
//  RegisterViewModel.swift
//  E-Identity
//
//  Created by Dimitris Kanellidis on 16/11/24.
//

import Foundation

class RegisterViewModel{
    func isEmptyValidation(text: String?) -> Bool{
        if text == nil || text == ""{
            return true
        }
        return false
    }
    
    func isValidEmail(text: String?) -> Bool{
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: text)
    }
    
    func isValidPassword(text: String?) -> Bool{
        if let text = text {
            if text.count > 5 {
                return true
            }
            return false
        }
        return false
    }
    
    func isTheSamePassword(firstPass: String?, secondPass: String?) -> Bool{
        if let firstPass = firstPass, let secondPass = secondPass {
            if firstPass == secondPass{
                return true
            }
            return false
        }
        return false
    }
    

}
