import Alamofire

class APIClient{
    // Base URL for all requests
       private let baseURL = "http://auth.e-id.gr:8080"

       // Helper function to perform a POST request with FormData encoding
    private func performPostRequest(endpoint: String, parameters: [String: Any], headers: HTTPHeaders, completion: @escaping (AFDataResponse<Data?>) -> Void) {
           let url = "\(baseURL)\(endpoint)"
        DispatchQueue.global().async{
            AF.upload(multipartFormData: { formData in
                for (key, value) in parameters {
                    if let stringValue = value as? String {
                        formData.append(Data(stringValue.utf8), withName: key)
                    } else if let fileURL = value as? URL {
                        formData.append(fileURL, withName: key, fileName: "file.jpg", mimeType: "image/jpeg")
                    }
                }
            }, to: url, headers: headers).response { response in
                debugPrint(response)
                completion(response)
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
       func login(email: String, password: String, token: String) {
           let loginParams: [String: Any] = [
               "email": email,
               "password": password
           ]
           let loginHeaders: HTTPHeaders = ["Authorization": "Bearer \(token)"]
           performPostRequest(endpoint: "/auth/login", parameters: loginParams, headers: loginHeaders) { response in
               
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
       func getUserDetails(token: String) {
           let userDetailsParams: [String: Any] = [
               "token": token
           ]
           let userDetailsHeaders: HTTPHeaders = ["Authorization": "Bearer \(token)"]
           performPostRequest(endpoint: "/user/get-user", parameters: userDetailsParams, headers: userDetailsHeaders) { response in
               
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
