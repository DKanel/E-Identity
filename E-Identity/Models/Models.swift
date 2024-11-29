//
//  Models.swift
//  E-Identity
//
//  Created by Dimitris Kanellidis on 29/11/24.
//

import Foundation
struct RegisterRequest: Encodable {
    let name: String
    let surname: String
    let email: String
    let password: String
}

struct LoginRequest: Encodable {
    let email: String
    let password: String
}

struct GenericResponse: Decodable {
    let message: String
}


// Model for the error object
struct ErrorDetail: Codable {
    let message: String
    let type: String
}

// Main model for the response
struct APIResponse: Codable {
    let error: ErrorDetail
    let status: String

    enum CodingKeys: String, CodingKey {
        case error
        case status
    }
}
