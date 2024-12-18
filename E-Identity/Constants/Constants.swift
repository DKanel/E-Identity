//
//  Constants.swift
//  E-Identity
//
//  Created by Dimitris Kanellidis on 29/11/24.
//

import Foundation

struct Constants{
    let token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3N1ZXIiOiJOaWtvcyBHa2V2cmVraXMiLCJlbWFpbCI6Im5pa29zZ2V2cmVAaXRpLmdyIiwicm9sZSI6ImFkbWluIiwibmFtZSI6Ik5pa29zIEdrZXZyZWtpcyJ9.9E4oloGfOXu6iPrJYfaO3wVlZnIe6wQ-flesdrLbNyQ"
    
}
// Helper to check regex matches
extension String {
    func matches(regex: String) -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: self)
    }
}
