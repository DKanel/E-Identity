import Alamofire

class APIClient{
    // Base URL for all requests
    private let baseURL = "http://auth.e-id.gr:8080"
    
    // Helper function to perform a POST request with FormData encoding
    private func performPostRequest(endpoint: String, parameters: [String: Any]?, headers: HTTPHeaders, completion: @escaping (Result<[String: Any], Error>) -> Void) {
        let url = "\(baseURL)\(endpoint)"
        
        DispatchQueue.global().async{
            AF.upload(multipartFormData: { formData in
                if let parameters = parameters {
                    for (key, value) in parameters {
                        if let stringValue = value as? String {
                            formData.append(Data(stringValue.utf8), withName: key)
                        } else if let fileURL = value as? URL {
                            formData.append(fileURL, withName: key, fileName: "file.jpg", mimeType: "image/jpeg")
                        }
                    }
                }
            }, to: url, headers: headers).response { response in
                switch response.result {
                case .success(let data):
                    if let data = data {
                        if let rawString = String(data: data, encoding: .utf8) {
                            print("Raw Response: \(rawString)")
                        }
                        do {
                            // Attempt to decode JSON response
                            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                                completion(.success(json))
                            } else {
                                let error = NSError(domain: "InvalidResponse", code: 0, userInfo: [NSLocalizedDescriptionKey: "Response is not valid JSON."])
                                completion(.failure(error))
                            }
                        } catch {
                            completion(.failure(error))
                        }
                    } else {
                        let error = NSError(domain: "NoData", code: 0, userInfo: [NSLocalizedDescriptionKey: "Response contains no data."])
                        completion(.failure(error))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    
    private func performGetRequest(endpoint: String, parameters: [String: Any]?, headers: HTTPHeaders, completion: @escaping (Result<[String: Any], Error>) -> Void) {
        let url = "\(baseURL)\(endpoint)"
        
        DispatchQueue.global().async {
            // Make the GET request with parameters and headers
            AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: headers).response { response in
                switch response.result {
                case .success(let data):
                    if let data = data {
                        // Print raw response for debugging
                        if let rawString = String(data: data, encoding: .utf8) {
                            print("Raw Response: \(rawString)")
                        }
                        do {
                            // Attempt to decode JSON response
                            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                                completion(.success(json))
                            } else {
                                let error = NSError(domain: "InvalidResponse", code: 0, userInfo: [NSLocalizedDescriptionKey: "Response is not valid JSON."])
                                completion(.failure(error))
                            }
                        } catch {
                            completion(.failure(error))
                        }
                    } else {
                        let error = NSError(domain: "NoData", code: 0, userInfo: [NSLocalizedDescriptionKey: "Response contains no data."])
                        completion(.failure(error))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    
    // Helper function to perform a DELETE request
    private func performDeleteRequest(endpoint: String, headers: HTTPHeaders) {
        let url = "\(baseURL)\(endpoint)"
        AF.request(url, method: .delete, headers: headers).response { response in
            debugPrint(response)
        }
    }
    
    // Register User
    func register(name: String, surname: String, email: String, password: String, token: String) {
        let registerParams: [String: Any] = [
            "name": name,
            "surname": surname,
            "email": email,
            "password": password
        ]
        let registerHeaders: HTTPHeaders = ["Authorization": "Bearer \(token)"]
        performPostRequest(endpoint: "/auth/register", parameters: registerParams, headers: registerHeaders) { response in
            
        }
    }
    
    // Login with Email
    func login(email: String, password: String, token: String, completion: @escaping(Result<LoginResponseModel,Error>) -> Void) {
        let loginParams: [String: Any] = [
            "email": email,
            "password": password
        ]
        let loginHeaders: HTTPHeaders = ["Authorization": "Bearer \(token)"]
        performPostRequest(endpoint: "/auth/login", parameters: loginParams, headers: loginHeaders) { response in
            do {
                if let responseDict = try? response.get() {
                    if let loginToken = responseDict["loginToken"] as? String,
                       let registrationStatus = responseDict["registration_status"] as? String,
                       let status = responseDict["status"] as? String {
                        let loginResponse = LoginResponseModel(
                            loginToken: loginToken,
                            registrationStatus: registrationStatus,
                            status: status
                        )
                        // Return the success result
                        completion(.success(loginResponse))
                    } else {
                        // Handle the case where any of the expected fields are missing
                        completion(.failure(LoginError.missingFields))
                    }
                } else {
                    // Handle invalid response
                    completion(.failure(LoginError.invalidResponse))
                }
            } catch {
                // Handle parsing errors
                completion(.failure(LoginError.parsingError))
            }
            
            // If an error object exists in the response
            if let responseDict = try? response.get(),
               let errorDict = responseDict["error"] as? [String: Any],
               let message = errorDict["message"] as? String {
                // Handle specific error messages
                completion(.failure(LoginError.custom(message: message)))
            }
        }
    }
    
    // Reset Password
    func resetPassword(email: String, password: String, token: String) {
        let resetPasswordParams: [String: Any] = [
            "email": email,
            "password": password,
            "token": token
        ]
        let resetPasswordHeaders: HTTPHeaders = ["Authorization": "Bearer \(token)"]
        performPostRequest(endpoint: "/auth/reset-password", parameters: resetPasswordParams, headers: resetPasswordHeaders) { response in
            
        }
    }
    
    // Upload E1 Document
    func uploadE1(token: String) {
        let uploadE1Params: [String: Any] = [:]
        let uploadE1Headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]
        performPostRequest(endpoint: "/auth/gov_doc/e1", parameters: uploadE1Params, headers: uploadE1Headers) { response in
            
        }
    }
    
    // Delete E1 Document
    func deleteE1(token: String) {
        let deleteE1Headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]
        performDeleteRequest(endpoint: "/auth/gov_doc/e1/delete", headers: deleteE1Headers)
    }
    
    func postLicenseRequest(name: String, surname: String, loginToken: String, token: String) {
        let parameters: [String: Any] = [
            "name": name,
            "surname": surname
        ]
        let headers: HTTPHeaders = [
            "x-login-token": loginToken,
            "Authorization": "Bearer \(token)"
        ]
        
        performPostRequest(endpoint: "/user/license", parameters: parameters, headers: headers) { result in
            switch result {
            case .success(let response):
                print("Response: \(response)")
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    
    // Upload Passport Document
    func uploadPassport(token: String, passportFileURL: URL) {
        let passportParams: [String: Any] = [
            "passport": passportFileURL
        ]
        let passportHeaders: HTTPHeaders = ["Authorization": "Bearer \(token)"]
        performPostRequest(endpoint: "/user/passport", parameters: passportParams, headers: passportHeaders) { response in
            
        }
    }
    
    // Delete Passport
    func deletePassport(token: String) {
        let deletePassportHeaders: HTTPHeaders = ["Authorization": "Bearer \(token)"]
        performDeleteRequest(endpoint: "/user/passport/delete", headers: deletePassportHeaders)
    }
    
    // Upload ID Document
    func uploadID(token: String, idFileURL: URL) {
        let idParams: [String: Any] = [
            "id": idFileURL
        ]
        let idHeaders: HTTPHeaders = ["Authorization": "Bearer \(token)"]
        performPostRequest(endpoint: "/user/identification", parameters: idParams, headers: idHeaders) { response in
            
        }
    }
    
    // Delete ID
    func deleteID(token: String) {
        let deleteIDHeaders: HTTPHeaders = ["Authorization": "Bearer \(token)"]
        performDeleteRequest(endpoint: "/user/identification/delete", headers: deleteIDHeaders)
    }
    
    // Get User Details
    func getUserDetails(token: String, loginToken: String) {
        let headers: HTTPHeaders = [
            "x-login-token": loginToken,
            "Authorization": "Bearer \(token)"
        ]
        
        performGetRequest(endpoint: "/user/get-user", parameters: nil, headers: headers) { response in
            print("USER DETAILS RESPONSE: \(response)")
        }
    }
    
    // Get Users
    func getUsers(token: String) {
        let getUsersParams: [String: Any] = [
            "loginToken": token
        ]
        let getUsersHeaders: HTTPHeaders = ["Authorization": "Bearer \(token)"]
        performPostRequest(endpoint: "/user/getUsers", parameters: getUsersParams, headers: getUsersHeaders) { response in
            
        }
    }
    
    // Register Palm (biometric data)
    func registerPalm(token: String, imageEmbeddings: [Float]) {
        let palmParams: [String: Any] = [
            "imageEmbeddings": imageEmbeddings
        ]
        let palmHeaders: HTTPHeaders = ["Authorization": "Bearer \(token)"]
        performPostRequest(endpoint: "/user/palm", parameters: palmParams, headers: palmHeaders) { response in
            
        }
    }
    
    // Delete Palm
    func deletePalm(token: String) {
        let deletePalmHeaders: HTTPHeaders = ["Authorization": "Bearer \(token)"]
        performDeleteRequest(endpoint: "/user/palm/delete", headers: deletePalmHeaders)
    }
    
    // Remove Palm Background
    func removePalmBackground(token: String, fileURL: URL) {
        let palmBgParams: [String: Any] = [
            "file": fileURL
        ]
        let palmBgHeaders: HTTPHeaders = ["Authorization": "Bearer \(token)"]
        performPostRequest(endpoint: "/user/palm/remove_bg", parameters: palmBgParams, headers: palmBgHeaders) { response in
            
        }
    }
    
    // Password Reset Request
    func resetPasswordRequest(email: String, token: String) {
        let resetPasswordRequestParams: [String: Any] = [
            "email": email
        ]
        let resetPasswordRequestHeaders: HTTPHeaders = ["Authorization": "Bearer \(token)"]
        performPostRequest(endpoint: "/auth/reset-password-request", parameters: resetPasswordRequestParams, headers: resetPasswordRequestHeaders) { response in
            
        }
    }
    
    // Verify Reset Token
    func verifyResetToken(token: String) {
        let verifyResetTokenHeaders: HTTPHeaders = ["Authorization": "Bearer \(token)"]
        performPostRequest(endpoint: "/auth/reset-token-verify", parameters: ["token": token], headers: verifyResetTokenHeaders) { response in
            
        }
    }
}
