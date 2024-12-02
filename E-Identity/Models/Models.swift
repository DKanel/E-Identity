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
struct ErrorResponse: Codable {
    let error: ErrorDetail
    let errorCode: Int
    let status: String

    struct ErrorDetail: Codable {
        let message: String
        let type: String
    }
}

struct LoginResponseModel: Codable {
    let loginToken: String
    let registrationStatus: String
    let status: String
    
    enum CodingKeys: String, CodingKey {
        case loginToken = "loginToken"
        case registrationStatus = "registration_status"
        case status
    }
}

enum LoginError: Error {
    case invalidResponse
    case missingFields
    case parsingError
    case custom(message: String)
    
    var localizedDescription: String {
        switch self {
        case .invalidResponse:
            return "Invalid response from server."
        case .missingFields:
            return "Required fields are missing in the response."
        case .parsingError:
            return "Failed to parse the response."
        case .custom(let message):
            return message
        }
    }
}
